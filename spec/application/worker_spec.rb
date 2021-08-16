require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe Worker, type: :model do
  describe 'Methods' do
    context "run cron job with correct forms" do
      before do
        @job = Sidekiq::Cron::Job.new(name: 'Leave Worker - every min', cron: '*/1 * * * *', class: 'LeaveWorker')
        # @job = Worker.perform(1)
      end
      it "Expect to check in a vehicle" do
        expect(@job.valid?).to eq true
      end
    end
  end
end
