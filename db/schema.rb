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

ActiveRecord::Schema.define(version: 2019_03_11_232431) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "street", null: false
    t.string "number", null: false
    t.string "neighborhood", null: false
    t.string "city", default: "Porto Velho"
    t.string "state", default: "Rondônia"
    t.string "country", default: "Brasil"
    t.string "zipcode"
    t.bigint "establishment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["establishment_id"], name: "index_addresses_on_establishment_id"
  end

  create_table "bank_dates", force: :cascade do |t|
    t.string "cpf_cnpj", null: false
    t.string "holder", null: false
    t.integer "bank_code", null: false
    t.string "agency", null: false
    t.string "account_number", null: false
    t.bigint "establishment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["establishment_id"], name: "index_bank_dates_on_establishment_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "establishments", force: :cascade do |t|
    t.string "cpf_cnpj", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone", null: false
    t.string "timetable", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_establishments_on_user_id"
  end

  create_table "linked_services", force: :cascade do |t|
    t.bigint "service_id"
    t.bigint "linked_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["linked_id"], name: "index_linked_services_on_linked_id"
    t.index ["service_id"], name: "index_linked_services_on_service_id"
  end

  create_table "office_hours", force: :cascade do |t|
    t.integer "hour_begin", null: false
    t.integer "hour_end", null: false
    t.bigint "professional_id"
    t.integer "week_day", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["professional_id"], name: "index_office_hours_on_professional_id"
  end

  create_table "professional_services", force: :cascade do |t|
    t.bigint "professional_id"
    t.bigint "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["professional_id"], name: "index_professional_services_on_professional_id"
    t.index ["service_id"], name: "index_professional_services_on_service_id"
  end

  create_table "professionals", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.bigint "establishment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["establishment_id"], name: "index_professionals_on_establishment_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.boolean "free", null: false
    t.datetime "date", null: false
    t.bigint "professional_service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["professional_service_id"], name: "index_schedules_on_professional_service_id"
  end

  create_table "schedulings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "service_id"
    t.integer "status", default: 0
    t.datetime "begin_time", null: false
    t.datetime "end_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_schedulings_on_service_id"
    t.index ["user_id"], name: "index_schedulings_on_user_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "title", null: false
    t.integer "status", default: 2, null: false
    t.integer "local_type", null: false
    t.text "description", null: false
    t.decimal "amount", null: false
    t.integer "duration", null: false
    t.bigint "category_id"
    t.bigint "establishment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_services_on_category_id"
    t.index ["establishment_id"], name: "index_services_on_establishment_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.string "provider"
    t.string "uid"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "establishments"
  add_foreign_key "bank_dates", "establishments"
  add_foreign_key "establishments", "users"
  add_foreign_key "linked_services", "services"
  add_foreign_key "linked_services", "services", column: "linked_id"
  add_foreign_key "office_hours", "professionals"
  add_foreign_key "professional_services", "professionals"
  add_foreign_key "professional_services", "services"
  add_foreign_key "professionals", "establishments"
  add_foreign_key "schedules", "professional_services"
  add_foreign_key "schedulings", "services"
  add_foreign_key "schedulings", "users"
  add_foreign_key "services", "categories"
  add_foreign_key "services", "establishments"
end
