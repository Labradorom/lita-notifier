# lita-notifier

TODO: Add a description of the plugin.

## Installation

Add lita-notifier to your Lita instance's Gemfile:

``` ruby
gem "lita-notifier"
```

## Configuration

### Required attributes

* `room_to_monitor` (String) - Name of the room to monitor for activity
* `room_to_notify` (String) - Name of the room to post notifications in
* `ignore_users` (Array) - Users not to notify about

### Example

```
Lita.configure do |config|
  config.handlers.notifier.room_to_monitor = '12345_customer_chat@conf.hipchat.com'
  config.handlers.notifier.room_to_notify = '12345_hidden_secret_room'
  config.handlers.notifier.ignore_users = ['Admin', 'Mike']
end


## Usage

When a user shows up in our public Customer Support HipChat room, we want to know about it in our private hanging-out room. This plugin takes care of that.
