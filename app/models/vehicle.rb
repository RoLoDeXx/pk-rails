class Vehicle < ApplicationRecord
  belongs_to :driver, optional: true

  def checkin_ticket(spot)
    if spot.parkable(id)
      ticket = Ticket.create!(
        spot_id: spot[:id],
        time_entry: Time.zone.now,
        driver_id: owner_driver_id,
      )
      spot.update(is_available: false, occupied_by: id)
      ticket
    end
  end

  def checkout_ticket(spot)
    if Ticket.exists?(spot_id: spot[:id])
      spot.update(is_available: true, occupied_by: nil)
      ticket = Ticket.find_by(spot_id: spot[:id])

      current_time = Time.zone.now
      hours = ((current_time - ticket.time_entry) / 1.hour)
      ticket.update(time_exit: current_time, fare: hours * 10.0)
      ticket
    else
      raise StandardError.new("Invalid ticket or parking spot")
    end
  end
end
