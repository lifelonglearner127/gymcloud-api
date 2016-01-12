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

ActiveRecord::Schema.define(version: 20160108154111) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "agreement_categories", force: :cascade do |t|
    t.string   "title"
    t.string   "pro_title"
    t.string   "client_title"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "symbol"
  end

  add_index "agreement_categories", ["symbol"], name: "index_agreement_categories_on_symbol", unique: true, using: :btree

  create_table "authentication_providers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "authentication_providers", ["name"], name: "index_authentication_providers_on_name", using: :btree

  create_table "client_group_memberships", force: :cascade do |t|
    t.integer  "client_group_id"
    t.integer  "client_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "client_group_memberships", ["client_id", "client_group_id"], name: "index_client_group_memberships_on_client_id_and_client_group_id", unique: true, using: :btree

  create_table "client_groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "pro_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "exercise_properties", force: :cascade do |t|
    t.integer  "personal_property_id"
    t.integer  "workout_exercise_id"
    t.integer  "value"
    t.integer  "position"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "exercise_properties", ["personal_property_id"], name: "index_exercise_properties_on_personal_property_id", using: :btree
  add_index "exercise_properties", ["workout_exercise_id"], name: "index_exercise_properties_on_workout_exercise_id", using: :btree

  create_table "exercise_result_items", force: :cascade do |t|
    t.integer  "exercise_result_id"
    t.integer  "exercise_property_id"
    t.integer  "value"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "exercise_result_items", ["exercise_property_id"], name: "index_exercise_result_items_on_exercise_property_id", using: :btree
  add_index "exercise_result_items", ["exercise_result_id"], name: "index_exercise_result_items_on_exercise_result_id", using: :btree

  create_table "exercise_results", force: :cascade do |t|
    t.integer  "workout_event_id"
    t.integer  "workout_exercise_id"
    t.boolean  "is_personal_best"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "exercise_results", ["workout_event_id"], name: "index_exercise_results_on_workout_event_id", using: :btree
  add_index "exercise_results", ["workout_exercise_id"], name: "index_exercise_results_on_workout_exercise_id", using: :btree

  create_table "exercises", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "video_url"
    t.boolean  "is_public"
    t.integer  "author_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "folder_id"
    t.datetime "deleted_at"
    t.integer  "video_id"
    t.integer  "user_id"
    t.integer  "original_id"
  end

  add_index "exercises", ["author_id"], name: "index_exercises_on_author_id", using: :btree
  add_index "exercises", ["deleted_at"], name: "index_exercises_on_deleted_at", using: :btree
  add_index "exercises", ["folder_id"], name: "index_exercises_on_folder_id", using: :btree
  add_index "exercises", ["original_id"], name: "index_exercises_on_original_id", using: :btree
  add_index "exercises", ["user_id"], name: "index_exercises_on_user_id", using: :btree

  create_table "folder_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "folder_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "folder_anc_desc_idx", unique: true, using: :btree
  add_index "folder_hierarchies", ["descendant_id"], name: "folder_desc_idx", using: :btree

  create_table "folders", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "parent_id"
  end

  add_index "folders", ["user_id"], name: "index_folders_on_user_id", using: :btree

  create_table "global_properties", force: :cascade do |t|
    t.string   "symbol"
    t.string   "name"
    t.string   "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "position"
  end

  add_index "global_properties", ["position"], name: "index_global_properties_on_position", unique: true, using: :btree
  add_index "global_properties", ["symbol"], name: "index_global_properties_on_symbol", unique: true, using: :btree

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "personal_programs", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "note"
    t.integer  "program_template_id"
    t.integer  "status"
    t.integer  "person_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "program_template_version"
  end

  add_index "personal_programs", ["person_id"], name: "index_personal_programs_on_person_id", using: :btree
  add_index "personal_programs", ["program_template_id"], name: "index_personal_programs_on_program_template_id", using: :btree

  create_table "personal_properties", force: :cascade do |t|
    t.integer  "global_property_id"
    t.integer  "position"
    t.boolean  "is_visible"
    t.integer  "person_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "personal_properties", ["global_property_id"], name: "index_personal_properties_on_global_property_id", using: :btree

  create_table "personal_workouts", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "note"
    t.integer  "workout_template_id"
    t.integer  "person_id"
    t.integer  "status"
    t.string   "video_url"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "workout_template_version"
    t.boolean  "is_program_part",          default: false
  end

  add_index "personal_workouts", ["person_id"], name: "index_personal_workouts_on_person_id", using: :btree
  add_index "personal_workouts", ["workout_template_id"], name: "index_personal_workouts_on_workout_template_id", using: :btree

  create_table "program_templates", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "note"
    t.boolean  "is_public"
    t.integer  "author_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "folder_id"
    t.datetime "deleted_at"
    t.integer  "user_id"
    t.integer  "original_id"
  end

  add_index "program_templates", ["author_id"], name: "index_program_templates_on_author_id", using: :btree
  add_index "program_templates", ["deleted_at"], name: "index_program_templates_on_deleted_at", using: :btree
  add_index "program_templates", ["folder_id"], name: "index_program_templates_on_folder_id", using: :btree
  add_index "program_templates", ["original_id"], name: "index_program_templates_on_original_id", using: :btree
  add_index "program_templates", ["user_id"], name: "index_program_templates_on_user_id", using: :btree

  create_table "program_weeks", force: :cascade do |t|
    t.string   "name"
    t.integer  "position"
    t.integer  "program_id"
    t.string   "program_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "program_weeks", ["program_type", "program_id"], name: "index_program_weeks_on_program_type_and_program_id", using: :btree

  create_table "program_workouts", force: :cascade do |t|
    t.integer  "workout_id"
    t.string   "workout_type"
    t.integer  "program_id"
    t.string   "program_type"
    t.text     "note"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "position"
    t.integer  "week_id"
  end

  add_index "program_workouts", ["program_type", "program_id"], name: "index_program_workouts_on_program_type_and_program_id", using: :btree
  add_index "program_workouts", ["workout_type", "workout_id"], name: "index_program_workouts_on_workout_type_and_workout_id", using: :btree

  create_table "read_marks", force: :cascade do |t|
    t.integer  "readable_id"
    t.string   "readable_type", limit: 255, null: false
    t.integer  "user_id",                   null: false
    t.datetime "timestamp"
  end

  add_index "read_marks", ["user_id", "readable_type", "readable_id"], name: "index_read_marks_on_user_id_and_readable_type_and_readable_id", using: :btree

  create_table "root_folder_categories", force: :cascade do |t|
    t.string "klass"
    t.string "name"
  end

  create_table "user_agreements", force: :cascade do |t|
    t.integer  "pro_id"
    t.integer  "client_id"
    t.integer  "category_id"
    t.integer  "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "user_authentications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "authentication_provider_id"
    t.string   "uid"
    t.text     "params"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "email"
  end

  add_index "user_authentications", ["authentication_provider_id"], name: "index_user_authentications_on_authentication_provider_id", using: :btree
  add_index "user_authentications", ["user_id"], name: "index_user_authentications_on_user_id", using: :btree

  create_table "user_profiles", force: :cascade do |t|
    t.integer  "gender"
    t.decimal  "height"
    t.decimal  "weight"
    t.decimal  "bodyfat"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "location"
    t.string   "zip"
    t.string   "employer"
    t.date     "birthday"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "avatar"
  end

  add_index "user_profiles", ["user_id"], name: "index_user_profiles_on_user_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "videos", force: :cascade do |t|
    t.integer  "vimeo_id"
    t.string   "tmp_file"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "privacy",             default: 1
    t.string   "name"
    t.integer  "duration"
    t.string   "preview_picture_url"
    t.string   "vimeo_url"
    t.string   "status"
    t.string   "embed_url"
    t.datetime "uploaded_at"
    t.integer  "author_id"
  end

  add_index "videos", ["author_id"], name: "index_videos_on_author_id", using: :btree

  create_table "workout_event_exercises", force: :cascade do |t|
    t.integer  "workout_event_id"
    t.integer  "workout_exercise_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workout_event_exercises", ["workout_event_id"], name: "index_workout_event_exercises_on_workout_event_id", using: :btree
  add_index "workout_event_exercises", ["workout_exercise_id"], name: "index_workout_event_exercises_on_workout_exercise_id", using: :btree

  create_table "workout_events", force: :cascade do |t|
    t.integer  "personal_workout_id"
    t.datetime "begins_at"
    t.datetime "ends_at"
    t.boolean  "is_completed"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "workout_events", ["personal_workout_id"], name: "index_workout_events_on_personal_workout_id", using: :btree

  create_table "workout_exercises", force: :cascade do |t|
    t.integer  "exercise_id"
    t.integer  "workout_id"
    t.text     "note"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "exercise_version"
    t.string   "workout_type"
    t.string   "order_name"
    t.integer  "position"
  end

  add_index "workout_exercises", ["exercise_id"], name: "index_workout_exercises_on_exercise_id", using: :btree
  add_index "workout_exercises", ["workout_id"], name: "index_workout_exercises_on_workout_id", using: :btree

  create_table "workout_templates", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "note"
    t.string   "video_url"
    t.boolean  "is_public"
    t.integer  "author_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "folder_id"
    t.boolean  "is_visible",  default: true
    t.datetime "deleted_at"
    t.integer  "video_id"
    t.integer  "user_id"
    t.integer  "original_id"
  end

  add_index "workout_templates", ["author_id"], name: "index_workout_templates_on_author_id", using: :btree
  add_index "workout_templates", ["deleted_at"], name: "index_workout_templates_on_deleted_at", using: :btree
  add_index "workout_templates", ["folder_id"], name: "index_workout_templates_on_folder_id", using: :btree
  add_index "workout_templates", ["original_id"], name: "index_workout_templates_on_original_id", using: :btree
  add_index "workout_templates", ["user_id"], name: "index_workout_templates_on_user_id", using: :btree

  add_foreign_key "exercise_properties", "personal_properties"
  add_foreign_key "exercise_properties", "workout_exercises"
  add_foreign_key "exercise_result_items", "exercise_properties"
  add_foreign_key "exercise_result_items", "exercise_results"
  add_foreign_key "exercise_results", "workout_events"
  add_foreign_key "exercise_results", "workout_exercises"
  add_foreign_key "folders", "users"
  add_foreign_key "personal_programs", "program_templates"
  add_foreign_key "personal_properties", "global_properties"
  add_foreign_key "personal_workouts", "workout_templates"
  add_foreign_key "user_authentications", "authentication_providers"
  add_foreign_key "user_authentications", "users"
  add_foreign_key "workout_event_exercises", "workout_events"
  add_foreign_key "workout_event_exercises", "workout_exercises"
  add_foreign_key "workout_events", "personal_workouts"
  add_foreign_key "workout_exercises", "exercises"
end
