# class to implement check in flow
class Checkin
  def self.entry(vehicle_id)
    vehicle_obj = Vehicle.find_by(id: vehicle_id)
    spot = ParkingSpot.get_empty_slot(vehicle_obj)
    vehicle_obj.checkin_ticket(spot)
  end
end
