# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_08_114449) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.integer "chat_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "province"
    t.integer "restaurants_count", default: 0
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "restaurant_id"
    t.string "body"
    t.string "commenter"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["restaurant_id"], name: "index_comments_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.bigint "city_id"
    t.string "name"
    t.string "dp_link"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "res_choice"
    t.string "author"
    t.boolean "confirmation", default: false
    t.integer "author_id"
    t.index "to_tsvector('english'::regconfig, (((name)::text || ' '::text) || description))", name: "restaurants_idx", using: :gin
    t.index ["city_id"], name: "index_restaurants_on_city_id"
  end

end
