class VehicleCrud
  def initialize(params)
    if Vehicle.exists?(params[:owner_driver_id])
      @number_plate = params[:number_plate]
      @make = params[:make]
      @owner_driver_id = params[:owner_driver_id]
      @is_two_wheeler = params[:is_two_wheeler]
      @driver = self.insert
    else
      raise StandardError.new("Driver id does not existo")
    end
  end

  def self.retrive_all
    Vehicle.all
  end

  def insert
    Vehicle.create!(
      number_plate: @number_plate,
      make: @make,
      owner_driver_id: @owner_driver_id,
      is_two_wheeler: @is_two_wheeler,
    )
  end
end
