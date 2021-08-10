class LeaveWorker
  include Sidekiq::Worker

  def perform
    Ticket.includes(:driver)
    Ticket.where(time_exit: nil).find_each(batch_size: 1000) do |ticket|
      current_time = Time.zone.now
      hours = ((current_time - ticket.time_entry) / 1.hour).floor
      if hours >= 1
        Rails.logger.info("Check out request to driver with id (#{ticket.driver_id}) to clear parking spot number (#{ticket.spot_id})")
      end
    end
  end
end
