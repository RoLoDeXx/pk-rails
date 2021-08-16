class Checkout
  require_relative "./exceptions"
  def initialize(vehicle_id)
    vehicle_obj = Vehicle.find_by(id: vehicle_id)
    unless vehicle_obj
      raise NonExistentEntity.new.message("Vehicle")
    end

    spot = ParkingSpot.find_by(occupied_by: vehicle_id)
    unless spot
      raise VehicleNotInGarage.new.message
    end
    @ticket = leave(vehicle_obj, spot)
  end

  def leave(vehicle_obj, spot)
    vehicle_obj.checkout_ticket(spot)
  end

  def fetch_ticket
   @ticket
  end 
end
