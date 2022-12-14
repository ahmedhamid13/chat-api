# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_221_001_225_538) do
  create_table 'chats', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb3', force: :cascade do |t|
    t.integer 'number', null: false
    t.integer 'messages_count', default: 0
    t.bigint 'system_application_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'lock_version', default: 0, null: false
    t.index %w[number system_application_id], name: 'index_chats_on_number_and_system_application_id', unique: true
    t.index ['system_application_id'], name: 'index_chats_on_system_application_id'
  end

  create_table 'messages', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb3', force: :cascade do |t|
    t.integer 'number', null: false
    t.text 'body'
    t.bigint 'chat_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['chat_id'], name: 'index_messages_on_chat_id'
    t.index %w[number chat_id], name: 'index_messages_on_number_and_chat_id', unique: true
  end

  create_table 'system_applications', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb3', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'token', null: false
    t.integer 'chats_count', default: 0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'lock_version', default: 0, null: false
    t.index ['token'], name: 'index_system_applications_on_token'
  end

  add_foreign_key 'chats', 'system_applications'
  add_foreign_key 'messages', 'chats'
end
