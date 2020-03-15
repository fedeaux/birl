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

ActiveRecord::Schema.define(version: 2020_03_15_010931) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "challenges", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "context_id"
    t.jsonb "entry_data_model", default: {}
    t.index ["context_id"], name: "index_challenges_on_context_id"
  end

  create_table "contexts", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.string "slug"
    t.bigint "user_id"
    t.jsonb "meta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_contexts_on_user_id"
  end

  create_table "days", force: :cascade do |t|
    t.bigint "user_id"
    t.string "stamp"
    t.boolean "planned"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "meta", default: {}
    t.string "name"
    t.index ["user_id"], name: "index_days_on_user_id"
  end

  create_table "entries", force: :cascade do |t|
    t.string "name"
    t.bigint "progression_id"
    t.string "values"
    t.text "observations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "value", default: {}
    t.index ["progression_id"], name: "index_entries_on_progression_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "context_id"
    t.index ["context_id"], name: "index_exercises_on_context_id"
    t.index ["group_id"], name: "index_exercises_on_group_id"
  end

  create_table "goal_entries", force: :cascade do |t|
    t.string "name"
    t.bigint "goal_id"
    t.datetime "start"
    t.datetime "finish"
    t.jsonb "meta", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["goal_id"], name: "index_goal_entries_on_goal_id"
  end

  create_table "goals", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.bigint "user_id"
    t.jsonb "meta", default: {}
    t.jsonb "recurrence_scheme"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_goals_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "context_id"
    t.index ["context_id"], name: "index_groups_on_context_id"
  end

  create_table "listers", force: :cascade do |t|
    t.string "name"
    t.jsonb "values", default: {"items"=>[]}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memes", force: :cascade do |t|
    t.string "type"
    t.datetime "done_at"
    t.bigint "user_id"
    t.jsonb "contents", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_memes_on_user_id"
  end

  create_table "progressions", force: :cascade do |t|
    t.string "name"
    t.string "details"
    t.bigint "challenge_id"
    t.bigint "exercise_id"
    t.datetime "last_entry_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "entries_count"
    t.bigint "context_id"
    t.jsonb "override_entry_data_model", default: {}
    t.index ["challenge_id"], name: "index_progressions_on_challenge_id"
    t.index ["context_id"], name: "index_progressions_on_context_id"
    t.index ["exercise_id"], name: "index_progressions_on_exercise_id"
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
    t.integer "weekday"
    t.jsonb "recurrence_scheme"
    t.datetime "executed_at"
    t.index ["training_id"], name: "index_sessions_on_training_id"
  end

  create_table "tag_taggables", force: :cascade do |t|
    t.string "taggable_type"
    t.bigint "taggable_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "meta", default: {}
    t.index ["tag_id"], name: "index_tag_taggables_on_tag_id"
    t.index ["taggable_type", "taggable_id"], name: "index_tag_taggables_on_taggable_type_and_taggable_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.jsonb "meta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.jsonb "color", default: {}
    t.jsonb "background_color", default: {}
    t.jsonb "parents_names", default: []
    t.string "fullname"
    t.index ["ancestry"], name: "index_tags_on_ancestry"
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "timelogs", force: :cascade do |t|
    t.datetime "start"
    t.datetime "finish"
    t.text "description"
    t.jsonb "meta"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "day_id"
    t.index ["day_id"], name: "index_timelogs_on_day_id"
    t.index ["user_id"], name: "index_timelogs_on_user_id"
  end

  create_table "trainings", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "context_id"
    t.index ["context_id"], name: "index_trainings_on_context_id"
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
    t.string "timezone"
    t.bigint "current_context_id"
    t.index ["current_context_id"], name: "index_users_on_current_context_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vocabularies", force: :cascade do |t|
    t.string "es"
    t.string "pt_br"
    t.string "en"
    t.string "comment"
    t.string "kind"
    t.jsonb "meta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "priority", default: 1
  end

  add_foreign_key "contexts", "users"
  add_foreign_key "days", "users"
  add_foreign_key "entries", "progressions"
  add_foreign_key "exercises", "groups"
  add_foreign_key "goal_entries", "goals"
  add_foreign_key "goals", "users"
  add_foreign_key "memes", "users"
  add_foreign_key "progressions", "challenges"
  add_foreign_key "progressions", "exercises"
  add_foreign_key "session_progressions", "progressions"
  add_foreign_key "session_progressions", "sessions"
  add_foreign_key "sessions", "trainings"
  add_foreign_key "tag_taggables", "tags"
  add_foreign_key "tags", "users"
  add_foreign_key "timelogs", "days"
  add_foreign_key "timelogs", "users"
  add_foreign_key "users", "contexts", column: "current_context_id"
end
