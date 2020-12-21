# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_20_212848) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drivers", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "vehicle_id"
    t.string "cities", array: true
    t.integer "max_stops_accepted"
    t.index ["vehicle_id"], name: "index_drivers_on_vehicle_id"
  end

  create_table "load_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "routes", force: :cascade do |t|
    t.datetime "starts_at", null: false
    t.datetime "ends_at", null: false
    t.bigint "load_type_id", null: false
    t.float "load_sum", null: false
    t.string "cities", array: true
    t.integer "stops_amount", null: false
    t.bigint "vehicle_id"
    t.bigint "driver_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["driver_id"], name: "index_routes_on_driver_id"
    t.index ["load_type_id"], name: "index_routes_on_load_type_id"
    t.index ["vehicle_id"], name: "index_routes_on_vehicle_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.float "capacity"
    t.bigint "load_type_id", null: false
    t.bigint "driver_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["driver_id"], name: "index_vehicles_on_driver_id"
    t.index ["load_type_id"], name: "index_vehicles_on_load_type_id"
  end

  add_foreign_key "drivers", "vehicles"
  add_foreign_key "routes", "drivers"
  add_foreign_key "routes", "load_types"
  add_foreign_key "routes", "vehicles"
  add_foreign_key "vehicles", "drivers"
  add_foreign_key "vehicles", "load_types"
end
