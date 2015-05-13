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

ActiveRecord::Schema.define(version: 20150513043835) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "banks", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "banks", ["user_id"], name: "index_banks_on_user_id", using: :btree

  create_table "envelopes", force: :cascade do |t|
    t.integer  "bank_id"
    t.string   "category"
    t.boolean  "deleted",                             default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "total",      precision: 11, scale: 2
    t.integer  "user_id"
  end

  add_index "envelopes", ["bank_id"], name: "index_envelopes_on_bank_id", using: :btree

  create_table "transactions", force: :cascade do |t|
    t.string   "name"
    t.string   "transaction_type"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "amount",               precision: 11, scale: 2
    t.integer  "user_id"
    t.integer  "envelope_id"
    t.integer  "institutionable_id"
    t.string   "institutionable_type"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.string   "remember_token"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
