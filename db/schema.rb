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

ActiveRecord::Schema[7.0].define(version: 2023_04_19_174159) do
  create_table "active_storage_attachments", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb3", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "categories", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cinemas", charset: "utf8mb3", force: :cascade do |t|
    t.string "location"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "movie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_favorites_on_movie_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "movie_categories", charset: "utf8mb3", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "movie_id"
    t.bigint "category_id"
    t.index ["category_id"], name: "index_movie_categories_on_category_id"
    t.index ["movie_id"], name: "index_movie_categories_on_movie_id"
  end

  create_table "movies", charset: "utf8mb3", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.float "rating"
    t.integer "duration_min"
    t.datetime "release_time"
    t.string "language"
    t.string "director"
    t.string "cast"
    t.integer "age_range"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "img_link"
  end

  create_table "payments", charset: "utf8mb3", force: :cascade do |t|
    t.decimal "total_cost", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "activation_digest"
    t.datetime "activated_at"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "rates", charset: "utf8mb3", force: :cascade do |t|
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "movie_id"
    t.index ["movie_id"], name: "index_rates_on_movie_id"
    t.index ["user_id"], name: "index_rates_on_user_id"
  end

  create_table "rooms", charset: "utf8mb3", force: :cascade do |t|
    t.integer "row"
    t.integer "length"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "cinema_id"
    t.string "name"
    t.index ["cinema_id"], name: "index_rooms_on_cinema_id"
  end

  create_table "show_times", charset: "utf8mb3", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "movie_id"
    t.bigint "room_id"
    t.index ["movie_id"], name: "index_show_times_on_movie_id"
    t.index ["room_id"], name: "index_show_times_on_room_id"
  end

  create_table "tickets", charset: "utf8mb3", force: :cascade do |t|
    t.string "seat_position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "show_time_id"
    t.bigint "payment_id"
    t.index ["payment_id"], name: "index_tickets_on_payment_id"
    t.index ["show_time_id", "seat_position"], name: "index_tickets_on_show_time_id_and_seat_position", unique: true
    t.index ["show_time_id"], name: "index_tickets_on_show_time_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "user_name"
    t.string "email"
    t.integer "phone"
    t.datetime "date_birth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.integer "role", default: 0
    t.string "remember_digest"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone"], name: "index_users_on_phone", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "favorites", "movies"
  add_foreign_key "favorites", "users"
  add_foreign_key "movie_categories", "categories"
  add_foreign_key "movie_categories", "movies"
  add_foreign_key "payments", "users"
  add_foreign_key "rates", "movies"
  add_foreign_key "rates", "users"
  add_foreign_key "rooms", "cinemas"
  add_foreign_key "show_times", "movies"
  add_foreign_key "show_times", "rooms"
  add_foreign_key "tickets", "payments"
  add_foreign_key "tickets", "show_times"
end
