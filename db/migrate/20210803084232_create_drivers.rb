class CreateDrivers < ActiveRecord::Migration[5.2]
  def change
    create_table :drivers do |t|
      t.string :license
      t.string :name
      t.integer :vehicle_id

      t.timestamps
    end
  end
end
