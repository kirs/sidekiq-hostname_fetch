require 'spec_helper'

class TestWorker
  include Sidekiq::Worker

  sidekiq_options queue: "important", host_specific: true

  def perform(foo, bar);end
end

describe Sidekiq::Worker do
  let(:current_time) { Time.now }

  describe "#perform_async_on_host" do
    it do
      allow_any_instance_of(TestWorker).to receive(:client_push).with do |args|
        expect(args["args"]).to eq(["arg1","arg2"])
        expect(args["queue"]).to eq("important_host_custom_host")
      end
      TestWorker.perform_async_on_host("custom_host", "arg1", "arg2")
    end
  end

  describe "#perform_async_on_current_host" do
    it do
      allow_any_instance_of(TestWorker).to receive(:current_hostname).and_return('job-01.rspec-runner.com')

      allow_any_instance_of(TestWorker).to receive(:client_push).with do |args|
        expect(args["args"]).to eq(["arg1","arg2"])
        expect(args["queue"]).to eq("important_host_job-01.rspec-runner.com")
      end
      TestWorker.perform_async_on_current_host("arg1", "arg2")
    end
  end

  describe "#perform_in_on_host" do
    it do
      allow_any_instance_of(TestWorker).to receive(:client_push).with do |args|
        expect(args["args"]).to eq(["arg1","arg2"])
        expect(args["at"]).to be_within(1).of(current_time.to_i)
        expect(args["queue"]).to eq("important_host_custom_host")
      end
      TestWorker.perform_in_on_host(current_time, "custom_host", "arg1", "arg2")
    end
  end

  describe "#perform_at_on_host" do
    it do
      allow_any_instance_of(TestWorker).to receive(:client_push).with do |args|
        expect(args["args"]).to eq(["arg1","arg2"])
        expect(args["at"]).to be_within(1).of(current_time.to_i)
        expect(args["queue"]).to eq("important_host_custom_host")
      end
      TestWorker.perform_at_on_host(current_time, "custom_host", "arg1", "arg2")
    end
  end

  describe "workers with host_specific option" do
    it do
      allow_any_instance_of(TestWorker).to receive(:current_hostname).and_return('job-01.rspec-runner.com')

      allow_any_instance_of(TestWorker).to receive(:client_push).with do |args|
        expect(args["args"]).to eq(["arg1","arg2"])
        expect(args["queue"]).to eq("important_host_job-01.rspec-runner.com")
      end
      TestWorker.perform_async("arg1", "arg2")
    end
  end
end
