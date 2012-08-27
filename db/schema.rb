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

ActiveRecord::Schema.define(:version => 20120827193002) do

  create_table "ryan_locations", :force => true do |t|
    t.string   "tweet_place_id"
    t.string   "name"
    t.string   "full_name"
    t.string   "country_code"
    t.string   "country"
    t.text     "polygon"
    t.float    "longitude"
    t.float    "latitude"
    t.boolean  "gmaps"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "ryan_locations", ["tweet_place_id"], :name => "index_ryan_locations_on_tweet_place_id"

  create_table "ryans", :force => true do |t|
    t.string   "tweet_id"
    t.string   "tweet"
    t.datetime "tweet_date"
    t.integer  "ryan_location_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "ryans", ["tweet_id"], :name => "index_ryans_on_tweet_id"

end
