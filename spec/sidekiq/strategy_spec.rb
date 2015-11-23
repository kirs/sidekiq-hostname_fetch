require 'spec_helper'

describe Sidekiq::HostnameFetch::Strategy do
  let(:queues) { %w(queue1 queue1 queue2 queue2) }
  let(:options) {{ queues: queues }}

  it do
    allow_any_instance_of(described_class).to receive(:current_hostname).and_return("job-01.rspec-runner.com")
    fetcher = described_class.new(options)

    fetcher_queues = fetcher.instance_variable_get("@queues")

    queues_with_hostname = queues.map { |q| "queue:#{q}_host_job-01.rspec-runner.com" }
    queues_without_hostname = queues.map { |q| "queue:#{q}" }
    expect(fetcher_queues).to eq(queues_with_hostname + queues_without_hostname)
  end
end