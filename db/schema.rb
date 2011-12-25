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

ActiveRecord::Schema.define(:version => 20110428155936) do

  create_table "blacklists", :force => true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "certificate_requests", :force => true do |t|
    t.string   "sender_name"
    t.string   "sender_email"
    t.string   "receiver_name"
    t.string   "receiver_email"
    t.string   "receiver_gender"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "cover_memo"
    t.string   "confirmation_code"
  end

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], :name => "idx_key"

  create_table "stars", :force => true do |t|
    t.string   "recipientName"
    t.string   "recipientEmail"
    t.string   "senderName"
    t.string   "senderEmail"
    t.string   "certificateDate"
    t.date     "creationDate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
