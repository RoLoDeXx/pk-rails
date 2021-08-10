class ParkingSpot < ApplicationRecord
  def self.get_empty_slot(vehicle)
    if vehicle
      spots = ParkingSpot.where(is_available: true, for_bikes_only: vehicle[:is_two_wheeler])
      spots.first
    else
      raise StandardError.new("Vehicle can't be mapped to a parking spot")
    end
  end

  def parkable(vehicle_id)
    !ParkingSpot.exists?(occupied_by: vehicle_id)
  end
end