require 'sidekiq'
require 'sidekiq/fetch'

module Sidekiq
  module HostnameFetch
    class Strategy < ::Sidekiq::BasicFetch
      def initialize(options)
        super
        @queues = @queues.map { |q| [q, "#{q}_host_#{current_hostname}"] }.flatten
      end

      private

      def current_hostname
        @current_hostname ||= `hostname`.strip
      end
    end
  end
end
