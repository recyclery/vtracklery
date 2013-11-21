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

ActiveRecord::Schema.define(version: 1) do

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "first_at"
    t.datetime "last_at"
    t.integer  "wday"
    t.integer  "s_hr"
    t.integer  "s_min"
    t.integer  "e_hr"
    t.integer  "e_min"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "work_statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "work_times", force: true do |t|
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "worker_id"
    t.integer  "status_id"
    t.integer  "work_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "work_times", ["status_id"], name: "index_work_times_on_status_id"
  add_index "work_times", ["work_status_id"], name: "index_work_times_on_work_status_id"
  add_index "work_times", ["worker_id"], name: "index_work_times_on_worker_id"

  create_table "workers", force: true do |t|
    t.string   "name"
    t.string   "image"
    t.boolean  "in_shop"
    t.string   "email"
    t.string   "phone"
    t.integer  "status_id",      default: 1
    t.integer  "work_status_id", default: 1
    t.boolean  "public_email",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workers", ["status_id"], name: "index_workers_on_status_id"
  add_index "workers", ["work_status_id"], name: "index_workers_on_work_status_id"

end
