class VehicleCrud
  require_relative "./exceptions"
  def initialize(params)
    if Driver.exists?(params[:owner_driver_id])
      @vehicle = Vehicle.create!(
        number_plate: params[:number_plate],
        make: params[:make],
        owner_driver_id: params[:owner_driver_id],
        is_two_wheeler: params[:is_two_wheeler],
      )
    else
      raise StandardError.new("Driver id does not existo")
    end
  end

  def fetch_vehicle
    @vehicle
  end
end
