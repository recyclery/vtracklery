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

ActiveRecord::Schema.define(version: 20170509183131) do

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "first_at"
    t.datetime "last_at"
    t.integer  "wday"
    t.integer  "s_hr"
    t.integer  "s_min",      default: 0
    t.integer  "e_hr"
    t.integer  "e_min",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", force: true do |t|
    t.integer  "worker_id"
    t.boolean  "assist_host"
    t.boolean  "host_program"
    t.boolean  "greet_open"
    t.integer  "frequency"
    t.boolean  "tues_vol"
    t.boolean  "tues_open"
    t.boolean  "thurs_youth"
    t.boolean  "thurs_open"
    t.boolean  "fri_vol"
    t.boolean  "sat_sale"
    t.boolean  "sat_open"
    t.integer  "can_name_bike"
    t.integer  "can_fix_flat"
    t.integer  "can_replace_tire"
    t.integer  "can_replace_seat"
    t.integer  "can_replace_cables"
    t.integer  "can_adjust_brakes"
    t.integer  "can_adjust_derailleurs"
    t.integer  "can_replace_brakes"
    t.integer  "can_replace_shifters"
    t.integer  "can_remove_pedals"
    t.integer  "replace_crank"
    t.integer  "can_adjust_bearing"
    t.integer  "can_overhaul_hubs"
    t.integer  "can_overhaul_bracket"
    t.integer  "can_overhaul_headset"
    t.integer  "can_true_wheels"
    t.integer  "can_replace_fork"
    t.boolean  "assist_youth"
    t.boolean  "assist_tuneup"
    t.boolean  "assist_overhaul"
    t.boolean  "pickup_donations"
    t.boolean  "taken_tuneup"
    t.boolean  "taken_overhaul"
    t.boolean  "drive_stick"
    t.boolean  "have_vehicle"
    t.boolean  "represent_recyclery"
    t.boolean  "sell_ebay"
    t.boolean  "organize_drive"
    t.boolean  "organize_events"
    t.boolean  "skill_graphic_design"
    t.boolean  "skill_drawing"
    t.boolean  "skill_photography"
    t.boolean  "skill_videography"
    t.boolean  "skill_programming"
    t.boolean  "skill_grants"
    t.boolean  "skill_newsletter"
    t.boolean  "skill_carpentry"
    t.boolean  "skill_coordination"
    t.boolean  "skill_fundraising"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "surveys", ["worker_id"], name: "index_surveys_on_worker_id"

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
    t.boolean  "in_shop",        default: false
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

  create_table "youth_point_transactions", force: true do |t|
    t.integer "points"
    t.integer "worker_id"
    t.text    "description"
  end

end
