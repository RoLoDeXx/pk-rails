class RenameOldTableToNewTable < ActiveRecord::Migration
    def change
      rename_table :driver, :vehicle_driver
    end 
  end