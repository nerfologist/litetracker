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

ActiveRecord::Schema.define(version: 20140725213730) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "project_collaborations", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "project_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_collaborations", ["project_id"], name: "index_project_collaborations_on_project_id", using: :btree
  add_index "project_collaborations", ["user_id", "project_id"], name: "index_project_collaborations_on_user_id_and_project_id", unique: true, using: :btree
  add_index "project_collaborations", ["user_id"], name: "index_project_collaborations_on_user_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "title",      null: false
    t.integer  "owner_id",   null: false
    t.integer  "velocity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["owner_id", "title"], name: "index_projects_on_owner_id_and_title", unique: true, using: :btree
  add_index "projects", ["owner_id"], name: "index_projects_on_owner_id", using: :btree

  create_table "stories", force: true do |t|
    t.integer  "tab_id"
    t.string   "title",      null: false
    t.string   "type"
    t.integer  "points"
    t.string   "state",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ord",        null: false
  end

  create_table "tabs", force: true do |t|
    t.string   "name",                      null: false
    t.integer  "project_id",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ord",                       null: false
    t.boolean  "visible",    default: true, null: false
  end

  add_index "tabs", ["project_id"], name: "index_tabs_on_project_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "session_token",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", using: :btree

end
