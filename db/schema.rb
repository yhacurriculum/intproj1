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

ActiveRecord::Schema.define(version: 20160708194404) do

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 191, null: false
    t.integer  "sluggable_id",               null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 191
    t.datetime "created_at",                 null: false
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "thredded_categories", force: :cascade do |t|
    t.integer  "messageboard_id",             null: false
    t.string   "name",            limit: 191, null: false
    t.string   "description",     limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "slug",            limit: 191, null: false
  end

  add_index "thredded_categories", ["messageboard_id", "slug"], name: "index_thredded_categories_on_messageboard_id_and_slug", unique: true
  add_index "thredded_categories", ["messageboard_id"], name: "index_thredded_categories_on_messageboard_id"
  add_index "thredded_categories", ["name"], name: "thredded_categories_name_ci"

  create_table "thredded_messageboard_users", force: :cascade do |t|
    t.integer  "thredded_user_detail_id",  null: false
    t.integer  "thredded_messageboard_id", null: false
    t.datetime "last_seen_at",             null: false
  end

  add_index "thredded_messageboard_users", ["thredded_messageboard_id", "last_seen_at"], name: "index_thredded_messageboard_users_for_recently_active"
  add_index "thredded_messageboard_users", ["thredded_messageboard_id", "thredded_user_detail_id"], name: "index_thredded_messageboard_users_primary"

  create_table "thredded_messageboards", force: :cascade do |t|
    t.string   "name",         limit: 255,                 null: false
    t.string   "slug",         limit: 191
    t.text     "description"
    t.integer  "topics_count",             default: 0
    t.integer  "posts_count",              default: 0
    t.boolean  "closed",                   default: false, null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "thredded_messageboards", ["closed"], name: "index_thredded_messageboards_on_closed"
  add_index "thredded_messageboards", ["slug"], name: "index_thredded_messageboards_on_slug"

  create_table "thredded_post_notifications", force: :cascade do |t|
    t.string   "email",      limit: 191, null: false
    t.integer  "post_id",                null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "post_type",  limit: 191
  end

  add_index "thredded_post_notifications", ["post_id", "post_type"], name: "index_thredded_post_notifications_on_post"

  create_table "thredded_posts", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.text     "content",         limit: 65535
    t.string   "ip",              limit: 255
    t.string   "source",          limit: 255,   default: "web"
    t.integer  "postable_id",     limit: 4
    t.integer  "messageboard_id",                               null: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "thredded_posts", ["messageboard_id"], name: "index_thredded_posts_on_messageboard_id"
  add_index "thredded_posts", ["postable_id"], name: "index_thredded_posts_on_postable_id"
  add_index "thredded_posts", ["postable_id"], name: "index_thredded_posts_on_postable_id_and_postable_type"
  add_index "thredded_posts", ["user_id"], name: "index_thredded_posts_on_user_id"

  create_table "thredded_private_posts", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.text     "content",     limit: 65535
    t.string   "ip",          limit: 255
    t.integer  "postable_id",               null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "thredded_private_topics", force: :cascade do |t|
    t.integer  "user_id",                              null: false
    t.integer  "last_user_id",                         null: false
    t.string   "title",        limit: 255,             null: false
    t.string   "slug",         limit: 191,             null: false
    t.integer  "posts_count",              default: 0
    t.string   "hash_id",      limit: 191,             null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "thredded_private_topics", ["hash_id"], name: "index_thredded_private_topics_on_hash_id"
  add_index "thredded_private_topics", ["slug"], name: "index_thredded_private_topics_on_slug"

  create_table "thredded_private_users", force: :cascade do |t|
    t.integer  "private_topic_id", limit: 4
    t.integer  "user_id",          limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "thredded_private_users", ["private_topic_id"], name: "index_thredded_private_users_on_private_topic_id"
  add_index "thredded_private_users", ["user_id"], name: "index_thredded_private_users_on_user_id"

  create_table "thredded_topic_categories", force: :cascade do |t|
    t.integer "topic_id",    null: false
    t.integer "category_id", null: false
  end

  add_index "thredded_topic_categories", ["category_id"], name: "index_thredded_topic_categories_on_category_id"
  add_index "thredded_topic_categories", ["topic_id"], name: "index_thredded_topic_categories_on_topic_id"

  create_table "thredded_topics", force: :cascade do |t|
    t.integer  "user_id",                                     null: false
    t.integer  "last_user_id",                                null: false
    t.string   "title",           limit: 255,                 null: false
    t.string   "slug",            limit: 191,                 null: false
    t.integer  "messageboard_id",                             null: false
    t.integer  "posts_count",                 default: 0,     null: false
    t.boolean  "sticky",                      default: false, null: false
    t.boolean  "locked",                      default: false, null: false
    t.string   "hash_id",         limit: 191,                 null: false
    t.string   "type",            limit: 191
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "thredded_topics", ["hash_id"], name: "index_thredded_topics_on_hash_id"
  add_index "thredded_topics", ["messageboard_id", "slug"], name: "index_thredded_topics_on_messageboard_id_and_slug", unique: true
  add_index "thredded_topics", ["messageboard_id"], name: "index_thredded_topics_on_messageboard_id"
  add_index "thredded_topics", ["user_id"], name: "index_thredded_topics_on_user_id"

  create_table "thredded_user_details", force: :cascade do |t|
    t.integer  "user_id",                        null: false
    t.datetime "latest_activity_at"
    t.integer  "posts_count",        default: 0
    t.integer  "topics_count",       default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.datetime "last_seen_at"
  end

  add_index "thredded_user_details", ["latest_activity_at"], name: "index_thredded_user_details_on_latest_activity_at"
  add_index "thredded_user_details", ["user_id"], name: "index_thredded_user_details_on_user_id"

  create_table "thredded_user_messageboard_preferences", force: :cascade do |t|
    t.integer  "user_id",                          null: false
    t.integer  "messageboard_id",                  null: false
    t.boolean  "notify_on_mention", default: true, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "thredded_user_messageboard_preferences", ["user_id", "messageboard_id"], name: "thredded_user_messageboard_preferences_user_id_messageboard_id", unique: true

  create_table "thredded_user_preferences", force: :cascade do |t|
    t.integer  "user_id",                          null: false
    t.boolean  "notify_on_mention", default: true, null: false
    t.boolean  "notify_on_message", default: true, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "thredded_user_preferences", ["user_id"], name: "index_thredded_user_preferences_on_user_id"

  create_table "thredded_user_private_topic_read_states", force: :cascade do |t|
    t.integer  "user_id",                 null: false
    t.integer  "postable_id",             null: false
    t.integer  "page",        default: 1, null: false
    t.datetime "read_at",                 null: false
  end

  add_index "thredded_user_private_topic_read_states", ["user_id", "postable_id"], name: "thredded_user_private_topic_read_states_user_postable", unique: true

  create_table "thredded_user_topic_read_states", force: :cascade do |t|
    t.integer  "user_id",                 null: false
    t.integer  "postable_id",             null: false
    t.integer  "page",        default: 1, null: false
    t.datetime "read_at",                 null: false
  end

  add_index "thredded_user_topic_read_states", ["user_id", "postable_id"], name: "thredded_user_topic_read_states_user_postable", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "email"
    t.string   "realname"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.text     "bio"
    t.string   "dob"
    t.string   "phone"
    t.string   "state"
    t.string   "city"
    t.string   "zip"
    t.boolean  "admin",              default: false
    t.string   "image_url"
    t.boolean  "ban",                default: false
  end

end
