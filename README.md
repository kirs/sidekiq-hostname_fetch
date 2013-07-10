# Sidekiq::HostnameFetch

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'sidekiq-hostname_fetch'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sidekiq-hostname_fetch

## Usage

TODO: Write usage instructions here


## Demo

Start up sidekiq via

```
bundle exec sidekiq -r ./demo.rb
```

and then you can open up an IRB session like so:

```ruby
bundle exec irb -r ./demo.rb
```

where you can then say

```ruby
HardWorker.perform_async <-- without plugin
HardWorker.perform_async_for_host "myhost" # <-- won't work
HardWorker.perform_async_for_host `hostname`.strip # <-- gonna work
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
