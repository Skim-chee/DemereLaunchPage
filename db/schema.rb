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

ActiveRecord::Schema.define(version: 20150906053542) do

  create_table "emails", force: :cascade do |t|
    t.string   "email",               limit: 255
    t.boolean  "activated",           limit: 1
    t.integer  "position",            limit: 4
    t.string   "email_confirm_token", limit: 255
    t.string   "referral_code",       limit: 255
    t.integer  "referrer_id",         limit: 4
    t.string   "name",                limit: 255
    t.string   "zipcode",             limit: 255
    t.boolean  "visited",             limit: 1,   default: false
    t.datetime "created_at"
  end

  create_table "ip_addresses", force: :cascade do |t|
    t.string  "address", limit: 255
    t.integer "count",   limit: 4
  end

end
