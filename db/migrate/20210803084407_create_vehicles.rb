class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.string :number_plate
      t.string :make
      t.integer :owner_driver_id
      t.boolean :is_two_wheeler

      t.timestamps
    end
  end
end
