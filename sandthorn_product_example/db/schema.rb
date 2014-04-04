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

ActiveRecord::Schema.define(version: 20140328132413) do

  create_table "aggregates", force: true do |t|
    t.string  "aggregate_id",      limit: 36, null: false
    t.integer "aggregate_version",            null: false
    t.string  "aggregate_type",               null: false
  end

  add_index "aggregates", ["aggregate_id"], name: "aggregates_aggregate_id_index", unique: true
  add_index "aggregates", ["aggregate_type", "aggregate_id"], name: "aggregates_aggregate_type_aggregate_id_index", unique: true
  add_index "aggregates", ["aggregate_type"], name: "aggregates_aggregate_type_index"

  create_table "event_store_sequel_migrations", force: true do |t|
    t.string    "migration_name", null: false
    t.timestamp "timestamp",      null: false
  end

  add_index "event_store_sequel_migrations", ["migration_name"], name: "event_store_sequel_migrations_migration_name_index", unique: true

  create_table "events", primary_key: "sequence_number", force: true do |t|
    t.integer   "aggregate_table_id"
    t.integer   "aggregate_version",  null: false
    t.string    "event_name",         null: false
    t.text      "event_data"
    t.timestamp "timestamp",          null: false
  end

  add_index "events", ["aggregate_table_id", "aggregate_version"], name: "events_aggregate_table_id_aggregate_version_index", unique: true
  add_index "events", ["aggregate_table_id"], name: "events_aggregate_table_id_index"
  add_index "events", ["event_name"], name: "events_event_name_index"

  create_table "products", force: true do |t|
    t.string   "name"
    t.integer  "price"
    t.string   "stock_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "snapshots", force: true do |t|
    t.integer "aggregate_version",  null: false
    t.text    "snapshot_data",      null: false
    t.integer "aggregate_table_id"
  end

  add_index "snapshots", ["aggregate_table_id"], name: "snapshots_aggregate_table_id_index", unique: true

end
