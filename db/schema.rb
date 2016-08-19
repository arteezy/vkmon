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

ActiveRecord::Schema.define(version: 20160616183152) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friends", force: :cascade do |t|
    t.string   "first_name",  null: false
    t.string   "last_name",   null: false
    t.boolean  "sex",         null: false
    t.string   "nickname"
    t.string   "domain",      null: false
    t.date     "bdate"
    t.string   "city"
    t.string   "country"
    t.string   "photo",       null: false
    t.string   "thumbnail",   null: false
    t.boolean  "has_mobile"
    t.boolean  "online",      null: false
    t.string   "deactivated"
    t.string   "status"
    t.datetime "last_seen"
    t.integer  "platform"
    t.string   "university"
    t.string   "graduation"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "friends_watchers", id: false, force: :cascade do |t|
    t.integer "friend_id"
    t.integer "watcher_id"
    t.index ["friend_id"], name: "index_friends_watchers_on_friend_id", using: :btree
    t.index ["watcher_id"], name: "index_friends_watchers_on_watcher_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email",                          null: false
    t.string   "encrypted_password", limit: 128, null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

  create_table "watchers", force: :cascade do |t|
    t.integer  "vk_id"
    t.string   "name"
    t.string   "photo"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "user_id"
    t.integer  "added_friends_ids",   default: [],              array: true
    t.integer  "deleted_friends_ids", default: [],              array: true
    t.index ["user_id"], name: "index_watchers_on_user_id", using: :btree
  end

  add_foreign_key "watchers", "users"
end
