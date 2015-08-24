require 'time'
module Lita
  module Handlers
    class Notifier < Handler
      # insert handler code here

      route(/.+/) do |response|
        room = response.message.room_object
        if room.name == config.handlers.notifier.room_to_monitor
          user_name = response.user.name
          if !config.handlers.notifier.ignore_users.include?(user_name)
            prev_seen_support = redis.hget(user_name, 'last_seen_support')
            redis.hset(user_name, 'last_seen_support', Time.now)
            if prev_seen_support
              prev_seen_time = Time.parse(prev_seen_support)
              if Time.now - prev_seen_time > (60 * 60)
                # Haven't seen this user in last 60 minutes
                robot.send_message(config.handlers.notifier.room_to_notify, "@all #{user_name} is speaking in #{room.name}")
              end
            else
              # Haven't seen this user before
              robot.send_message(config..handlers.notifierroom_to_notify, "@all #{user_name} is speaking in #{room.name}")
            end
          end
        end
      end

      Lita.register_handler(self)
    end
  end
end
