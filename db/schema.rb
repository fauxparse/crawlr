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

ActiveRecord::Schema.define(version: 20150727210250) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abilities", force: :cascade do |t|
    t.integer "character_id"
    t.string  "stat",         limit: 3, null: false
    t.integer "base",                   null: false
  end

  create_table "ability_bonuses", force: :cascade do |t|
    t.integer "character_id"
    t.string  "stat",         limit: 3
    t.integer "bonus"
  end

  create_table "characters", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "ability_strategy_name"
    t.string   "race_name",             default: "human/standard"
    t.integer  "level",                 default: 1,                null: false
    t.string   "character_class_name",  default: "fighter",        null: false
  end

  add_foreign_key "abilities", "characters", on_delete: :cascade
  add_foreign_key "ability_bonuses", "characters", on_delete: :cascade
end
