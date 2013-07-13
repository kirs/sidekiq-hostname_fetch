require 'celluloid'
require 'sidekiq'
require 'sidekiq/fetch'

module Sidekiq
  module HostnameFetch
    class Strategy < ::Sidekiq::BasicFetch
      def initialize(options)
        @strictly_ordered_queues = !!options[:strict]
        @queues = options[:queues].map { |q| "queue:#{q}" }
        @queues = @queues.map { |q| [q, "#{q}_host_#{current_hostname}"] }.flatten

        @unique_queues = @queues.uniq
      end

      private

      def current_hostname
        @current_hostname ||= `hostname`.strip
      end
    end
  end
end
