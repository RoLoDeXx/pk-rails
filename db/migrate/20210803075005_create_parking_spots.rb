class CreateParkingSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :parking_spots do |t|
      t.integer :spot_number
      t.boolean :for_bikes_only

      t.timestamps
    end
  end
end
