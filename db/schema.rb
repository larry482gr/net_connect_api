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

ActiveRecord::Schema.define(version: 20160413144859) do

  create_table "routers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "ssid"
    t.string   "mac_address"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "user_profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "photo"
    t.string   "bg_photo"
    t.string   "about_me"
    t.integer  "age"
    t.date     "birthday"
    t.string   "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_profiles", ["user_id"], name: "index_user_profiles_on_user_id", using: :btree

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "fb_user_id"
    t.string   "fb_access_token"
    t.integer  "router_id"
    t.string   "local_ip"
    t.integer  "local_port"
    t.string   "external_address"
    t.decimal  "latitude",         precision: 18, scale: 15
    t.decimal  "longitude",        precision: 18, scale: 15
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "users", ["fb_access_token"], name: "index_users_on_fb_access_token", unique: true, using: :btree
  add_index "users", ["fb_user_id"], name: "index_users_on_fb_user_id", unique: true, using: :btree
  add_index "users", ["router_id"], name: "index_users_on_router_id", using: :btree

  add_foreign_key "user_profiles", "users"
  add_foreign_key "users", "routers"
end
