class Worker
  def self.perform(time_frame=1)
    Ticket.where(time_exit: nil).find_each(batch_size: 1000) do |ticket|
      current_time = Time.zone.now
      hours = ((current_time - ticket.time_entry) / 1.hour).ceil
      if hours >= time_frame
        puts("Check out driver with id (#{ticket.id}) to clear parking spot number (#{ticket.spot_id})")
      else
        puts("Waiting for driver wait time expiration")
      end
    end
  end
end
