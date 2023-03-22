# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_03_22_141439) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cinemas", force: :cascade do |t|
    t.string "location"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.float "rating"
    t.integer "duration_min"
    t.datetime "release_time"
    t.string "language"
    t.string "director"
    t.string "cast"
    t.integer "age_range"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.index ["category_id"], name: "index_movies_on_category_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "status"
    t.decimal "total_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "rates", force: :cascade do |t|
    t.text "comment"
    t.integer "favorite"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "movie_id"
    t.index ["movie_id"], name: "index_rates_on_movie_id"
    t.index ["user_id"], name: "index_rates_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "row"
    t.integer "length"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "cinema_id"
    t.index ["cinema_id"], name: "index_rooms_on_cinema_id"
  end

  create_table "show_times", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "movie_id"
    t.bigint "room_id"
    t.index ["movie_id"], name: "index_show_times_on_movie_id"
    t.index ["room_id"], name: "index_show_times_on_room_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "price"
    t.integer "type"
    t.string "seat_number"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "show_time_id"
    t.bigint "payment_id"
    t.index ["payment_id"], name: "index_tickets_on_payment_id"
    t.index ["show_time_id"], name: "index_tickets_on_show_time_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name"
    t.string "email"
    t.integer "phone"
    t.datetime "date_birth"
    t.integer "sex"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone"], name: "index_users_on_phone", unique: true
  end

  add_foreign_key "movies", "categories"
  add_foreign_key "payments", "users"
  add_foreign_key "rates", "movies"
  add_foreign_key "rates", "users"
  add_foreign_key "rooms", "cinemas"
  add_foreign_key "show_times", "movies"
  add_foreign_key "show_times", "rooms"
  add_foreign_key "tickets", "payments"
  add_foreign_key "tickets", "show_times"
end
