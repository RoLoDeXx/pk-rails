class LeaveWorker
  include Sidekiq::Worker
  require_relative("../application/worker")
  def perform
    Worker.perform(1)
  end
end
