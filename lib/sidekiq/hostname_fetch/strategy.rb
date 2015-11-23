require 'sidekiq'
require 'sidekiq/fetch'

module Sidekiq
  module HostnameFetch
    class Strategy < ::Sidekiq::BasicFetch
      def initialize(options)
        @strictly_ordered_queues = !!options[:strict]
        @queues = options[:queues].map { |q| "queue:#{q}" }
        @queues.unshift *@queues.map { |q| "#{q}_host_#{current_hostname}" }
        if @strictly_ordered_queues
          @queues = @queues.uniq
          @queues << TIMEOUT
        end
      end

      private

      def current_hostname
        @current_hostname ||= `hostname`.strip
      end
    end
  end
end
