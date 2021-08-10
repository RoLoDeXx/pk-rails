class ApplicationJob < ActiveJob::Base
    include Sidekiq::Worker

    def perform(args)
      # block that will be retried in case of failure
    end
end
