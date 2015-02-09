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

ActiveRecord::Schema.define(version: 20150209013744) do

  create_table "bootsy_image_galleries", force: :cascade do |t|
    t.integer  "bootsy_resource_id"
    t.string   "bootsy_resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: :cascade do |t|
    t.string   "image_file"
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carpools", force: :cascade do |t|
    t.integer  "trip_id"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "make"
    t.string   "model"
    t.integer  "year"
    t.string   "color"
    t.datetime "leave_time"
    t.string   "leave_location"
    t.integer  "seats"
    t.string   "nickname"
    t.text     "message"
  end

  add_index "carpools", ["trip_id"], name: "index_carpools_on_trip_id"
  add_index "carpools", ["user_id"], name: "index_carpools_on_user_id"

  create_table "trips", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "user_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "description"
    t.string   "experience_level"
    t.datetime "pretrip_datetime"
    t.string   "pretrip_location"
    t.integer  "cost"
    t.string   "location"
    t.integer  "spots"
    t.integer  "status"
    t.integer  "ask_tent"
    t.integer  "ask_bag"
    t.integer  "ask_pad"
    t.integer  "ask_pack"
    t.integer  "ask_diet"
    t.integer  "ask_bike_rack"
    t.integer  "ask_helmet"
    t.integer  "ask_headlamp"
    t.integer  "ask_harness"
    t.integer  "ask_kayak"
    t.integer  "ask_climbing_shoes"
    t.integer  "ask_kneepads"
    t.integer  "ask_bike"
  end

  add_index "trips", ["user_id"], name: "index_trips_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.integer  "role"
    t.integer  "waiver_signed"
    t.integer  "dues_paid"
    t.datetime "waiver_signed_date"
    t.datetime "dues_paid_date"
    t.string   "ec_name"
    t.string   "ec_type"
    t.string   "ec_phone1"
    t.string   "ec_phone2"
    t.string   "ec_email"
    t.string   "activation_digest"
    t.integer  "activated",          default: 0
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "users_cars", force: :cascade do |t|
    t.integer  "carpool_id"
    t.integer  "users_trip_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "users_cars", ["carpool_id"], name: "index_users_cars_on_carpool_id"
  add_index "users_cars", ["users_trip_id"], name: "index_users_cars_on_users_trip_id"

  create_table "users_trips", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "trip_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "on_waitlist"
    t.integer  "ask_tent"
    t.integer  "ask_bag"
    t.integer  "ask_pad"
    t.integer  "ask_pack"
    t.string   "ask_diet"
    t.integer  "ask_bike_rack"
    t.integer  "ask_helmet"
    t.integer  "ask_headlamp"
    t.integer  "ask_harness"
    t.integer  "ask_kayak"
    t.integer  "ask_climbing_shoes"
    t.integer  "ask_kneepads"
    t.integer  "ask_bike"
  end

  add_index "users_trips", ["trip_id"], name: "index_users_trips_on_trip_id"
  add_index "users_trips", ["user_id"], name: "index_users_trips_on_user_id"

end
