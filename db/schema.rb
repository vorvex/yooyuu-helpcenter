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

ActiveRecord::Schema.define(version: 2019_03_07_111611) do

  create_table "questions", force: :cascade do |t|
    t.string "head"
    t.string "body"
    t.string "image_url"
    t.string "thumbnail_url"
    t.string "video_url"
    t.string "sort"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "steps", force: :cascade do |t|
    t.integer "step"
    t.integer "tour_id"
    t.string "head"
    t.string "body"
    t.string "sort"
    t.string "video_url"
    t.string "image_url"
    t.integer "est_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "secondary_button_link"
    t.string "secondary_button_text"
  end

  create_table "tours", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "path"
    t.string "final_path"
  end

end
