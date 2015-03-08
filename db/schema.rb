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

ActiveRecord::Schema.define(version: 20150308112234) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "cases", force: true do |t|
    t.string   "title"
    t.string   "sponsor"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "done",                  default: false
    t.string   "sponsor_logo"
    t.boolean  "case_sponsor",          default: false
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
  end

  create_table "delegates", force: true do |t|
    t.string   "email",                           default: "",  null: false
    t.string   "encrypted_password",              default: "",  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                   default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "peer_feedback_received"
    t.string   "fullname"
    t.integer  "feedback_id"
    t.string   "linkedin"
    t.string   "facebook"
    t.string   "twitter"
    t.integer  "case_wins",                       default: 0
    t.decimal  "total_score",                     default: 0.0
    t.integer  "case_one_score",                  default: 0
    t.integer  "case_two_score",                  default: 0
    t.integer  "case_three_score",                default: 0
    t.integer  "case_four_score",                 default: 0
    t.string   "delegate_program"
    t.integer  "num_complete_cases",              default: 0
    t.decimal  "estimated_overall_contribution",  default: 0.0
    t.decimal  "estimated_leadership",            default: 0.0
    t.decimal  "estimated_business_sense",        default: 0.0
    t.decimal  "estimated_creativity",            default: 0.0
    t.decimal  "estimated_presentation_skills",   default: 0.0
    t.decimal  "case1_peer_leadership",           default: 0.0
    t.decimal  "case1_peer_creativity",           default: 0.0
    t.decimal  "case1_peer_business_sense",       default: 0.0
    t.decimal  "case1_peer_presentation_skills",  default: 0.0
    t.decimal  "case1_peer_overall_contribution", default: 0.0
    t.decimal  "case1_exec_leadership",           default: 0.0
    t.decimal  "case1_exec_creativity",           default: 0.0
    t.decimal  "case1_exec_business_sense",       default: 0.0
    t.decimal  "case1_exec_presentation_skills",  default: 0.0
    t.decimal  "case1_exec_overall_contribution", default: 0.0
    t.integer  "case1_num_peer_evals",            default: 0
    t.integer  "case1_num_exec_evals",            default: 0
    t.decimal  "case2_peer_leadership",           default: 0.0
    t.decimal  "case2_peer_creativity",           default: 0.0
    t.decimal  "case2_peer_business_sense",       default: 0.0
    t.decimal  "case2_peer_presentation_skills",  default: 0.0
    t.decimal  "case2_peer_overall_contribution", default: 0.0
    t.decimal  "case2_exec_leadership",           default: 0.0
    t.decimal  "case2_exec_creativity",           default: 0.0
    t.decimal  "case2_exec_business_sense",       default: 0.0
    t.decimal  "case2_exec_presentation_skills",  default: 0.0
    t.decimal  "case2_exec_overall_contribution", default: 0.0
    t.integer  "case2_num_peer_evals",            default: 0
    t.integer  "case2_num_exec_evals",            default: 0
    t.decimal  "case3_peer_leadership",           default: 0.0
    t.decimal  "case3_peer_creativity",           default: 0.0
    t.decimal  "case3_peer_business_sense",       default: 0.0
    t.decimal  "case3_peer_presentation_skills",  default: 0.0
    t.decimal  "case3_peer_overall_contribution", default: 0.0
    t.decimal  "case3_exec_leadership",           default: 0.0
    t.decimal  "case3_exec_creativity",           default: 0.0
    t.decimal  "case3_exec_business_sense",       default: 0.0
    t.decimal  "case3_exec_presentation_skills",  default: 0.0
    t.decimal  "case3_exec_overall_contribution", default: 0.0
    t.integer  "case3_num_peer_evals",            default: 0
    t.integer  "case3_num_exec_evals",            default: 0
    t.decimal  "case4_peer_leadership",           default: 0.0
    t.decimal  "case4_peer_creativity",           default: 0.0
    t.decimal  "case4_peer_business_sense",       default: 0.0
    t.decimal  "case4_peer_presentation_skills",  default: 0.0
    t.decimal  "case4_peer_overall_contribution", default: 0.0
    t.decimal  "case4_exec_leadership",           default: 0.0
    t.decimal  "case4_exec_creativity",           default: 0.0
    t.decimal  "case4_exec_business_sense",       default: 0.0
    t.decimal  "case4_exec_presentation_skills",  default: 0.0
    t.decimal  "case4_exec_overall_contribution", default: 0.0
    t.integer  "case4_num_peer_evals",            default: 0
    t.integer  "case4_num_exec_evals",            default: 0
    t.decimal  "case1_impact",                    default: 0.0
    t.decimal  "case1_feasibility",               default: 0.0
    t.decimal  "case1_innovation",                default: 0.0
    t.decimal  "case1_presentation",              default: 0.0
    t.decimal  "case1_overall",                   default: 0.0
    t.decimal  "case2_impact",                    default: 0.0
    t.decimal  "case2_feasibility",               default: 0.0
    t.decimal  "case2_innovation",                default: 0.0
    t.decimal  "case2_presentation",              default: 0.0
    t.decimal  "case2_overall",                   default: 0.0
    t.decimal  "case3_impact",                    default: 0.0
    t.decimal  "case3_feasibility",               default: 0.0
    t.decimal  "case3_innovation",                default: 0.0
    t.decimal  "case3_presentation",              default: 0.0
    t.decimal  "case3_overall",                   default: 0.0
    t.decimal  "case4_impact",                    default: 0.0
    t.decimal  "case4_feasibility",               default: 0.0
    t.decimal  "case4_innovation",                default: 0.0
    t.decimal  "case4_presentation",              default: 0.0
    t.decimal  "case4_overall",                   default: 0.0
    t.integer  "case1_eval_count",                default: 0
    t.integer  "case2_eval_count",                default: 0
    t.integer  "case3_eval_count",                default: 0
    t.integer  "case4_eval_count",                default: 0
  end

  add_index "delegates", ["email"], name: "index_delegates_on_email", unique: true
  add_index "delegates", ["reset_password_token"], name: "index_delegates_on_reset_password_token", unique: true

  create_table "delegates_groups", id: false, force: true do |t|
    t.integer "delegate_id"
    t.integer "group_id"
  end

  create_table "execs", force: true do |t|
    t.string   "exec_name"
    t.string   "team"
    t.text     "responsibilities"
    t.string   "program"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "position"
    t.string   "picture"
  end

  create_table "feedbacks", force: true do |t|
    t.string   "receiver"
    t.text     "good_comments"
    t.text     "improvement_comments"
    t.integer  "leadership"
    t.integer  "creativity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "delegate_id"
  end

  create_table "groups", force: true do |t|
    t.string   "group_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "itineraries", force: true do |t|
    t.string   "item"
    t.time     "item_time"
    t.string   "day"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "item_time_end"
  end

  create_table "leaderships", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rs_evaluations", force: true do |t|
    t.string   "reputation_name"
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "target_id"
    t.string   "target_type"
    t.float    "value",           default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "data"
  end

  add_index "rs_evaluations", ["reputation_name", "source_id", "source_type", "target_id", "target_type"], name: "index_rs_evaluations_on_reputation_name_and_source_and_target", unique: true
  add_index "rs_evaluations", ["reputation_name"], name: "index_rs_evaluations_on_reputation_name"
  add_index "rs_evaluations", ["source_id", "source_type"], name: "index_rs_evaluations_on_source_id_and_source_type"
  add_index "rs_evaluations", ["target_id", "target_type"], name: "index_rs_evaluations_on_target_id_and_target_type"

  create_table "rs_reputation_messages", force: true do |t|
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "receiver_id"
    t.float    "weight",      default: 1.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rs_reputation_messages", ["receiver_id", "sender_id", "sender_type"], name: "index_rs_reputation_messages_on_receiver_id_and_sender", unique: true
  add_index "rs_reputation_messages", ["receiver_id"], name: "index_rs_reputation_messages_on_receiver_id"
  add_index "rs_reputation_messages", ["sender_id", "sender_type"], name: "index_rs_reputation_messages_on_sender_id_and_sender_type"

  create_table "rs_reputations", force: true do |t|
    t.string   "reputation_name"
    t.float    "value",           default: 0.0
    t.string   "aggregated_by"
    t.integer  "target_id"
    t.string   "target_type"
    t.boolean  "active",          default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "data"
  end

  add_index "rs_reputations", ["reputation_name", "target_id", "target_type"], name: "index_rs_reputations_on_reputation_name_and_target", unique: true
  add_index "rs_reputations", ["reputation_name"], name: "index_rs_reputations_on_reputation_name"
  add_index "rs_reputations", ["target_id", "target_type"], name: "index_rs_reputations_on_target_id_and_target_type"

end
