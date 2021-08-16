class NonExistentDriver < StandardError
  def message
    ERR_MSG
  end

  private

  ERR_MSG = "Driver does not exist".freeze
end

class NonExistentVehicle < StandardError
  def message
    ERR_MSG
  end

  private

  ERR_MSG = "Vehicle does not exist".freeze
end

class NoParkingSpot < StandardError
  def message
    ERR_MSG
  end

  private

  ERR_MSG = "No parking spot available".freeze
end

class VehicleNotInGarage < StandardError
  def message
    ERR_MSG
  end

  private

  ERR_MSG = "Vehicle not parked in garage".freeze
end
