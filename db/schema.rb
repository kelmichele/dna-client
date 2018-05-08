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

ActiveRecord::Schema.define(version: 2018_05_08_133005) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clinics", force: :cascade do |t|
    t.string "lab"
    t.string "detail"
    t.string "addr1"
    t.string "addr2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone"
    t.string "ext"
    t.string "fax"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addr1"], name: "index_clinics_on_addr1"
    t.index ["city"], name: "index_clinics_on_city"
    t.index ["lab"], name: "index_clinics_on_lab"
    t.index ["state"], name: "index_clinics_on_state"
    t.index ["zip"], name: "index_clinics_on_zip"
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "abv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["abv"], name: "index_states_on_abv"
    t.index ["name"], name: "index_states_on_name"
  end

  create_table "towns", force: :cascade do |t|
    t.string "townname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "state_id"
    t.index ["id"], name: "index_towns_on_id"
    t.index ["townname"], name: "index_towns_on_townname"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "firstname", null: false
    t.string "lastname", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["firstname"], name: "index_users_on_firstname"
    t.index ["lastname"], name: "index_users_on_lastname"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
