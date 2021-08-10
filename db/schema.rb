# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_03_200400) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drivers", force: :cascade do |t|
    t.string "license"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parking_spots", force: :cascade do |t|
    t.integer "spot_number"
    t.boolean "for_bikes_only"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_available"
    t.integer "occupied_by"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "spot_id"
    t.datetime "time_entry"
    t.datetime "time_exit"
    t.float "fare"
    t.integer "driver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_id"], name: "index_tickets_on_driver_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "number_plate"
    t.string "make"
    t.integer "owner_driver_id"
    t.boolean "is_two_wheeler"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
