class Checkout
  def self.leave(vehicle_id)
    vehicle_obj = Vehicle.find_by(id: vehicle_id)
    spot = ParkingSpot.find_by(occupied_by: vehicle_id)
    vehicle_obj.checkout_ticket(spot)
  end
end
