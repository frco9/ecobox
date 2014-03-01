# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140227204026) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actuators", force: true do |t|
    t.boolean  "activated",     default: false
    t.float    "frequency"
    t.string   "name"
    t.integer  "modulation_id"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "actuators_data_types", force: true do |t|
    t.integer  "actuator_id"
    t.integer  "data_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_actuators", force: true do |t|
    t.float    "value"
    t.integer  "actuator_id"
    t.integer  "data_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_sensors", force: true do |t|
    t.float    "value"
    t.integer  "sensor_id"
    t.integer  "data_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "data_sensors", ["data_type_id"], name: "index_data_sensors_on_data_type_id", using: :btree
  add_index "data_sensors", ["sensor_id"], name: "index_data_sensors_on_sensor_id", using: :btree

  create_table "data_types", force: true do |t|
    t.string "name"
  end

  create_table "modulations", force: true do |t|
    t.string "name"
  end

  create_table "rooms", force: true do |t|
    t.string  "name"
    t.integer "surface"
  end

  create_table "sensors", force: true do |t|
    t.float    "frequency"
    t.string   "name"
    t.integer  "modulation_id"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sensors", ["modulation_id"], name: "index_sensors_on_modulation_id", using: :btree
  add_index "sensors", ["room_id"], name: "index_sensors_on_room_id", using: :btree

  create_table "sensors_data_types", id: false, force: true do |t|
    t.integer "sensor_id"
    t.integer "data_type_id"
  end

  add_index "sensors_data_types", ["sensor_id", "data_type_id"], name: "index_sensors_data_types_on_sensor_id_and_data_type_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "firstname"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
