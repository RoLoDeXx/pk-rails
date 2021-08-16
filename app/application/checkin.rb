class Checkin
  def initialize(vehicle_id)
    vehicle_obj = Vehicle.find_by(id: vehicle_id)
    unless vehicle_obj
      raise NonExistentEntity.new.message("Vehicle")
    end

    spot = ParkingSpot.get_empty_slot(vehicle_obj)
    if !spot
      raise NoParkingSpot.new.message
    end

    @ticket = entry(vehicle_obj, spot)
  end

  def entry(vehicle_obj, spot)
    vehicle_obj.checkin_ticket(spot)
  end

  def fetch_ticket
    @ticket
  end
end
