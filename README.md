# Sidekiq::HostnameFetch Strategy

[![Build Status](https://travis-ci.org/kirs/sidekiq-hostname_fetch.png?branch=master)](https://travis-ci.org/kirs/sidekiq-hostname_fetch)

Imagine: you have 10 sidekiq job servers and you want to enque some job on specific server. With this strategy you can easily do this.

Sponsored by [Evil Martians](http://evl.ms).

Thanks to [Yaroslav Markin](https://github.com/yaroslav) and [Alexey Gaziev](https://github.com/gazay) for advice about making this project.

## Installation

Add this line to your application's Gemfile:

    gem 'sidekiq-hostname_fetch', github: "kirs/sidekiq-hostname_fetch"

And then execute:

    $ bundle

## Usage

Define the hostname strategy:

```ruby
Sidekiq.configure_server do |config|
  config.options[:fetch] = Sidekiq::HostnameFetch::Strategy
end
```

Now Sidekiq server will fetch tasks also from hostname-specific queues.

To send jobs to specific server, you can use:

```
MyWorker.perform_async_on_host "app-03.beta.myproject.com", "arg_to_worker", "another_arg"
```

As well as `perform_in_on_host` and `perform_at_on_host`.

Another way is to declate `sidekiq_options host_specific: true` inside the worker.
With this option, task will be always performed on the same server it was enqueed.

## Simple demo

(you can pick up `demo.rb` from this repo)

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
HardWorker.perform_async # <-- without plugin
HardWorker.perform_async_on_host "myhost" # <-- won't work
HardWorker.perform_async_on_host `hostname`.strip # <-- gonna work on your machine
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
