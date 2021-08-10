class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.integer :spot_id
      t.datetime :time_entry
      t.datetime :time_exit
      t.float :fare
      t.integer :driver_id

      t.timestamps
    end
    add_index :tickets, :driver_id
  end
end
