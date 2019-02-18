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

ActiveRecord::Schema.define(version: 2019_02_18_214501) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "challenges", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_challenges_on_user_id"
  end

  create_table "entries", force: :cascade do |t|
    t.string "name"
    t.bigint "progression_id"
    t.string "values"
    t.string "variables"
    t.text "observations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["progression_id"], name: "index_entries_on_progression_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.bigint "user_id"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_exercises_on_group_id"
    t.index ["user_id"], name: "index_exercises_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "progressions", force: :cascade do |t|
    t.string "name"
    t.string "details"
    t.bigint "user_id"
    t.bigint "challenge_id"
    t.bigint "exercise_id"
    t.datetime "last_entry_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "entries_count"
    t.index ["challenge_id"], name: "index_progressions_on_challenge_id"
    t.index ["exercise_id"], name: "index_progressions_on_exercise_id"
    t.index ["user_id"], name: "index_progressions_on_user_id"
  end

  create_table "session_progressions", force: :cascade do |t|
    t.bigint "session_id"
    t.bigint "progression_id"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["progression_id"], name: "index_session_progressions_on_progression_id"
    t.index ["session_id"], name: "index_session_progressions_on_session_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "name"
    t.bigint "training_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["training_id"], name: "index_sessions_on_training_id"
  end

  create_table "trainings", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_trainings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "challenges", "users"
  add_foreign_key "entries", "progressions"
  add_foreign_key "exercises", "groups"
  add_foreign_key "exercises", "users"
  add_foreign_key "groups", "users"
  add_foreign_key "progressions", "challenges"
  add_foreign_key "progressions", "exercises"
  add_foreign_key "progressions", "users"
  add_foreign_key "session_progressions", "progressions"
  add_foreign_key "session_progressions", "sessions"
  add_foreign_key "sessions", "trainings"
  add_foreign_key "trainings", "users"
end
