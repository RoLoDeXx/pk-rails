class NonExistentEntity < StandardError
  def initialize(class_name ="this class")
    @entity = class_name
  end 

  def message
    ERR_MSG
  end
  private
  ERR_MSG = "No entity for #{@entity} exists".freeze
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
