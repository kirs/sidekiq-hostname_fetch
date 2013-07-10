require 'celluloid'
require 'sidekiq'
require 'sidekiq/fetch'

module Sidekiq
  module HostnameFetch
    class Strategy < ::Sidekiq::BasicFetch
      CURRENT_HOSTNAME = `hostname`.strip

      def initialize(options)
        @strictly_ordered_queues = !!options[:strict]
        @queues = options[:queues].map { |q| "queue:#{q}" }
        @queues = @queues.map { |q| [q, "#{q}_host_#{CURRENT_HOSTNAME}"] }.flatten

        puts "@queues", @queues.join(",")
        @unique_queues = @queues.uniq
      end
    end
  end
end
