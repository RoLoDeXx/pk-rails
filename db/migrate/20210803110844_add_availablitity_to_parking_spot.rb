class AddAvailablitityToParkingSpot < ActiveRecord::Migration[5.2]
  def change
    add_column :parking_spots, :is_available, :boolean
  end
end
