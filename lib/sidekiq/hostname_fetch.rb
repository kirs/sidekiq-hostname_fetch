require "sidekiq/hostname_fetch/version"
require "sidekiq/extensions/worker"

module Sidekiq
  module HostnameFetch
    require_relative 'hostname_fetch/strategy'
  end
end
