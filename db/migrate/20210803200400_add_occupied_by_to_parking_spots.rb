class AddOccupiedByToParkingSpots < ActiveRecord::Migration[5.2]
  def change
    add_column :parking_spots, :occupied_by, :integer
  end
end
