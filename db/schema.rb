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

ActiveRecord::Schema.define(version: 20160522180000) do

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.text     "biography"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "poems", force: :cascade do |t|
    t.integer  "author_id"
    t.string   "title"
    t.text     "metaphor"
    t.text     "content"
    t.boolean  "published"
    t.datetime "publish_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "poems", ["author_id"], name: "index_poems_on_author_id"

  create_table "short_stories", force: :cascade do |t|
    t.integer  "author_id"
    t.string   "title"
    t.text     "description"
    t.text     "content"
    t.boolean  "published"
    t.datetime "publish_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "short_stories", ["author_id"], name: "index_short_stories_on_author_id"

  create_table "tag_authors", force: :cascade do |t|
    t.integer "tag_id"
    t.integer "author_id"
    t.integer "weight"
  end

  add_index "tag_authors", ["author_id"], name: "index_tag_authors_on_author_id"
  add_index "tag_authors", ["tag_id"], name: "index_tag_authors_on_tag_id"

  create_table "tag_poems", force: :cascade do |t|
    t.integer "tag_id"
    t.integer "poem_id"
    t.integer "weight"
  end

  add_index "tag_poems", ["poem_id"], name: "index_tag_poems_on_poem_id"
  add_index "tag_poems", ["tag_id"], name: "index_tag_poems_on_tag_id"

  create_table "tag_short_stories", force: :cascade do |t|
    t.integer "tag_id"
    t.integer "short_story_id"
    t.integer "weight"
  end

  add_index "tag_short_stories", ["short_story_id"], name: "index_tag_short_stories_on_short_story_id"
  add_index "tag_short_stories", ["tag_id"], name: "index_tag_short_stories_on_tag_id"

  create_table "tags", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
