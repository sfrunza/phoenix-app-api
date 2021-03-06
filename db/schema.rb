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

ActiveRecord::Schema.define(version: 2022_01_06_042246) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "floor"
    t.string "apt_number"
    t.boolean "is_origin", default: false
    t.boolean "is_destination", default: false
    t.boolean "is_pickup", default: false
    t.boolean "is_dropoff", default: false
    t.bigint "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_addresses_on_job_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "add_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "customers_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "customer_id", null: false
    t.index ["customer_id", "user_id"], name: "index_customers_users_on_customer_id_and_user_id"
    t.index ["user_id", "customer_id"], name: "index_customers_users_on_user_id_and_customer_id"
  end

  create_table "galleries", force: :cascade do |t|
    t.string "item"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string "image"
    t.string "photo"
    t.integer "job_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "pick_up_date"
    t.string "delivery_date"
    t.boolean "is_flat_rate", default: false
    t.boolean "is_confirmed_by_customer", default: false
    t.boolean "is_confirmed_by_manager", default: false
    t.integer "storage_fee"
    t.string "job_type"
    t.string "start_time"
    t.string "job_status"
    t.string "job_size"
    t.integer "crew_size"
    t.integer "job_rate"
    t.integer "time_between"
    t.float "estimated_time", default: [], array: true
    t.integer "travel_time", default: [], array: true
    t.integer "estimated_quote", default: [], array: true
    t.text "additional_info"
    t.float "job_duration"
    t.float "total_amount"
    t.bigint "customer_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "deposit"
    t.boolean "is_deposit_paid", default: false, null: false
    t.index ["customer_id"], name: "index_jobs_on_customer_id"
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "jobs_users", id: false, force: :cascade do |t|
    t.bigint "job_id", null: false
    t.bigint "user_id", null: false
    t.index ["job_id", "user_id"], name: "index_jobs_users_on_job_id_and_user_id"
    t.index ["user_id", "job_id"], name: "index_jobs_users_on_user_id_and_job_id"
  end

  create_table "prices", force: :cascade do |t|
    t.integer "two_men", default: [], array: true
    t.integer "three_men", default: [], array: true
    t.integer "four_men", default: [], array: true
    t.integer "add_men", default: [], array: true
    t.integer "add_truck", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rates", force: :cascade do |t|
    t.string "date"
    t.string "rates", default: [], array: true
    t.string "rate_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "receipts", force: :cascade do |t|
    t.string "file"
    t.bigint "job_id"
    t.index ["job_id"], name: "index_receipts_on_job_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "role"
    t.string "phone"
    t.integer "rate"
    t.string "ssn"
    t.string "address"
    t.boolean "active", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
