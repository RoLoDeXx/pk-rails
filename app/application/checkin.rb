# class to implement check in flow
require_relative "./exceptions"
class Checkin
  def initialize(vehicle_id)
    vehicle_obj = Vehicle.find_by(id: vehicle_id)

    spot = ParkingSpot.get_empty_slot(vehicle_obj)
    if !spot
      raise StandardError.new("No spot available")
    end

    @ticket = entry(vehicle_obj, spot)
  end

  def entry(vehicle_obj, spot)
    vehicle_obj.checkin_ticket(spot)
  end
end
