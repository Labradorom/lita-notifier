require 'time'
module Lita
  module Handlers
    class Notifier < Handler
      config :room_to_monitor
      config :room_to_notify
      config :ignore_users
      config :debug

      route(/.+/) do |response|
        room = response.message.room_object
        log_if_debug "Notifier: room: #{room.name}"
        if room.name == config.room_to_monitor
          user_name = response.user.name
          log_if_debug "Notifier: user: #{user_name}"
          if !config.ignore_users.include?(user_name)
            prev_seen_support = redis.hget(user_name, 'last_seen_support')
            log_if_debug "Notifier: prev_seen_support: #{prev_seen_support}"
            redis.hset(user_name, 'last_seen_support', Time.now)
            if prev_seen_support
              prev_seen_time = Time.parse(prev_seen_support)
              if Time.now - prev_seen_time > (60 * 60)
                # Haven't seen this user in last 60 minutes
                robot.send_message(config.room_to_notify, "@all #{user_name} is speaking in #{room.name}")
              else
                log_if_debug "Notifier: already notified in last hour"
              end
            else
              # Haven't seen this user before
              robot.send_message(config.room_to_notify, "@all #{user_name} is speaking in #{room.name}")
            end
          end
        end
      end

      def log_if_debug(message)
        if config.debug
          Lita.logger.info message
        end
      end

      Lita.register_handler(self)
    end
  end
end
