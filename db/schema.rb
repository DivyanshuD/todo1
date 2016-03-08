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

ActiveRecord::Schema.define(version: 20160301111400) do

  create_table "tags", force: :cascade do |t|
    t.string   "tag",        limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "tags", ["tag"], name: "index_tags_on_tag", unique: true, using: :btree

  create_table "tags_tasks", id: false, force: :cascade do |t|
    t.integer "task_id", limit: 4, null: false
    t.integer "tag_id",  limit: 4, null: false
  end

  add_index "tags_tasks", ["tag_id", "task_id"], name: "index_tags_tasks_on_tag_id_and_task_id", unique: true, using: :btree
  add_index "tags_tasks", ["task_id", "tag_id"], name: "index_tags_tasks_on_task_id_and_tag_id", unique: true, using: :btree

  create_table "tasks", force: :cascade do |t|
    t.string   "task_name",   limit: 50,  null: false
    t.string   "description", limit: 255, null: false
    t.boolean  "status",                  null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "tasks", ["task_name"], name: "index_tasks_on_task_name", unique: true, using: :btree

end
