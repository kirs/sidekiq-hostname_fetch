require 'rubygems'
require 'bundler'
Bundler.require(:default)

class HardWorker
  include Sidekiq::Worker

  # you can use host_specific flag
  # sidekiq_options queue: 'high', host_specific: true

  def perform
    host = `hostname`
    puts "i'm performed on #{host}"
  end
end

# If your client is single-threaded, we just need a single connection in our Redis connection pool
Sidekiq.configure_client do |config|
  config.redis = { :namespace => 'demo', :url => 'redis://localhost/14' }
end

# Sidekiq server is multi-threaded so our Redis connection pool size defaults to concurrency (-c)
Sidekiq.configure_server do |config|
  config.redis = { :namespace => 'demo', :url => 'redis://localhost/14' }
  config.options[:fetch] = Sidekiq::HostnameFetch::Strategy
end
