class RemoveVehicleIdFromDrivers < ActiveRecord::Migration[5.2]
  def change
    remove_column :drivers, :vehicle_id, :integer
  end
end
