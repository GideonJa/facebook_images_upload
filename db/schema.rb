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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120417061347) do

  create_table "events", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "events", ["user_id"], :name => "index_events_on_user_id"

  create_table "photos", :force => true do |t|
    t.integer  "event_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "service_id"
    t.text     "metadata"
    t.string   "provider_uid"
    t.integer  "user_id"
  end

  add_index "photos", ["event_id"], :name => "index_photos_on_event_id"
  add_index "photos", ["service_id", "provider_uid"], :name => "index_photos_on_service_id_and_provider_uid"
  add_index "photos", ["user_id"], :name => "index_photos_on_user_id"

  create_table "providers", :force => true do |t|
    t.string   "name"
    t.integer  "order"
    t.string   "consumer_key"
    t.string   "consumer_secret"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "services", :force => true do |t|
    t.integer  "user_id"
    t.integer  "provider_id"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.string   "oauth_token_secret"
    t.string   "description"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.datetime "import_started_at"
    t.datetime "import_ended_at"
    t.integer  "import_total_photos"
    t.integer  "import_num_photos"
    t.text     "metadata"
  end

  add_index "services", ["provider_id"], :name => "index_services_on_service_provider_id"
  add_index "services", ["user_id"], :name => "index_services_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
