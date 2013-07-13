require 'sidekiq/hostname_fetch'
require 'celluloid/autostart'
require 'sidekiq/fetch'

Sidekiq.logger = nil
Sidekiq.redis = { namespace: ENV['namespace'] }

RSpec.configure do |config|
  config.before :each do
    # Sidekiq.redis do |it|
    # end
  end
end
