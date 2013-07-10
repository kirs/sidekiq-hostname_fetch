module Sidekiq::Worker::ClassMethods
  CURRENT_HOST = `hostname`.strip

  def perform_async(*args)
    @host_specific_worker ||= get_sidekiq_options["host_specific"]

    if @host_specific_worker
      perform_async_for_host CURRENT_HOST, *args
    else
      client_push('class' => self, 'args' => args)
    end
  end

  def perform_async_for_host(host, *args)
    # puts "queue_for_host(host)", queue_for_host(host)
    client_push('class' => self, 'args' => args, 'queue' => queue_for_host(host))
  end

  def perform_in_for_host(host, interval, *args)
    int = interval.to_f
    ts = (int < 1_000_000_000 ? Time.now.to_f + int : int)
    client_push('class' => self, 'args' => args, 'at' => ts, 'queue' => queue_for_host(host))
  end
  alias_method :perform_at_for_host, :perform_in_for_host

  def queue_for_host(host)
    worker_queue = get_sidekiq_options['queue']
    "#{worker_queue}_host_#{host}"
  end
end