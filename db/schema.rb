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

ActiveRecord::Schema.define(version: 20160908152352) do

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.string   "company"
    t.string   "address_street"
    t.string   "address_zip_code"
    t.string   "address_city"
    t.string   "address_country"
    t.integer  "distributor_id"
    t.integer  "responsible_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["distributor_id"], name: "index_customers_on_distributor_id"
    t.index ["responsible_id"], name: "index_customers_on_responsible_id"
  end

  create_table "distributors", force: :cascade do |t|
    t.string   "company"
    t.string   "address_street"
    t.string   "address_zip_code"
    t.string   "address_city"
    t.string   "address_country"
    t.integer  "responsible_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["responsible_id"], name: "index_distributors_on_responsible_id"
  end

  create_table "distributors_products", force: :cascade do |t|
    t.integer "distributor_id"
    t.integer "product_id"
    t.index ["distributor_id"], name: "index_distributors_products_on_distributor_id"
    t.index ["product_id"], name: "index_distributors_products_on_product_id"
  end

  create_table "downloads", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "name"
    t.string   "description"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "download_count",    default: 0
    t.index ["product_id"], name: "index_downloads_on_product_id"
  end

  create_table "license_pools", force: :cascade do |t|
    t.integer "distributor_id"
    t.integer "product_id"
    t.string  "feature_name"
    t.integer "feature_stock"
    t.index ["distributor_id"], name: "index_license_pools_on_distributor_id"
    t.index ["product_id"], name: "index_license_pools_on_product_id"
  end

  create_table "license_usages", force: :cascade do |t|
    t.integer  "distributor_id"
    t.integer  "product_id"
    t.string   "feature_name"
    t.integer  "feature_total"
    t.integer  "feature_delta"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["created_at"], name: "index_license_usages_on_created_at"
    t.index ["distributor_id", "feature_name"], name: "index_license_usages_distributor_feature_name"
    t.index ["distributor_id", "product_id", "feature_name"], name: "index_license_usages_distributor_product_feature_name"
    t.index ["distributor_id"], name: "index_license_usages_on_distributor_id"
    t.index ["product_id"], name: "index_license_usages_on_product_id"
  end

  create_table "licenses", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "customer_id"
    t.string   "serial_number"
    t.string   "machine_code"
    t.date     "valid_until"
    t.text     "features"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["customer_id"], name: "index_licenses_on_customer_id"
    t.index ["product_id"], name: "index_licenses_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "version"
    t.text     "features"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "roles_mask"
    t.string   "family_name"
    t.datetime "last_seen"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",                     null: false
    t.integer  "item_id",                       null: false
    t.string   "event",                         null: false
    t.string   "whodunnit"
    t.text     "object",     limit: 1073741823
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end
