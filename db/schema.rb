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

ActiveRecord::Schema.define(version: 20160304161205) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "approved_buy_cats", force: :cascade do |t|
    t.integer  "trader_id"
    t.integer  "buy_cat_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "status"
    t.string   "document_file_name",    limit: 255
    t.string   "document_content_type", limit: 255
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
  end

  create_table "approved_sell_cats", force: :cascade do |t|
    t.integer  "trader_id"
    t.integer  "sell_cat_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "status"
    t.string   "document_file_name",    limit: 255
    t.string   "document_content_type", limit: 255
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
  end

  create_table "bids", force: :cascade do |t|
    t.float   "amount"
    t.integer "post_id"
    t.boolean "highest_bid", default: false
    t.integer "trader_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "impressions", force: :cascade do |t|
    t.string   "impressionable_type", limit: 255
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name",     limit: 255
    t.string   "action_name",         limit: 255
    t.string   "view_name",           limit: 255
    t.string   "request_hash",        limit: 255
    t.string   "ip_address",          limit: 255
    t.string   "session_hash",        limit: 255
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", using: :btree
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id", using: :btree

  create_table "pictures", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "hidden"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "description",        limit: 255
    t.float    "price"
    t.integer  "trader_id"
    t.boolean  "private",                        default: false
    t.boolean  "delivery",                       default: false
    t.boolean  "active",                         default: true
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "subcategory_id"
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "location",           limit: 255
    t.integer  "views"
    t.integer  "delivery_days"
    t.boolean  "report"
    t.boolean  "provide_samples"
    t.string   "quantity",           limit: 255
    t.string   "line1",              limit: 255
    t.string   "city",               limit: 255
    t.string   "county",             limit: 255
    t.string   "postcode",           limit: 255
    t.integer  "highest_bidder",                 default: 0
    t.boolean  "auction"
    t.boolean  "expired",                        default: false
    t.integer  "no_of_bids",                     default: 0
  end

  create_table "request_samples", force: :cascade do |t|
    t.string "seller_id",         limit: 255
    t.string "requestee_id",      limit: 255
    t.string "post_id",           limit: 255
    t.string "delivery_location", limit: 255
    t.string "line1",             limit: 255
    t.string "city",              limit: 255
    t.string "county",            limit: 255
    t.string "postcode",          limit: 255
  end

  create_table "subcategories", force: :cascade do |t|
    t.integer "category_id"
    t.string  "name",        limit: 255
  end

  add_index "subcategories", ["name"], name: "index_subcategories_on_name", unique: true, using: :btree

  create_table "traders", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "username",               limit: 255
    t.string   "image_file_name",        limit: 255
    t.string   "image_content_type",     limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "picture_id"
    t.boolean  "admin"
    t.text     "description"
  end

  add_index "traders", ["email"], name: "index_traders_on_email", unique: true, using: :btree
  add_index "traders", ["picture_id"], name: "index_traders_on_picture_id", using: :btree
  add_index "traders", ["reset_password_token"], name: "index_traders_on_reset_password_token", unique: true, using: :btree
  add_index "traders", ["username"], name: "index_traders_on_username", unique: true, using: :btree

  create_table "trades", force: :cascade do |t|
    t.datetime "time"
    t.string   "delivery_location", limit: 255
    t.integer  "post_id"
    t.integer  "trader_id"
    t.text     "feedback"
    t.integer  "rating",                        default: 0
    t.string   "line1",             limit: 255
    t.string   "city",              limit: 255
    t.string   "county",            limit: 255
    t.string   "postcode",          limit: 255
  end

  add_foreign_key "traders", "pictures"
end
