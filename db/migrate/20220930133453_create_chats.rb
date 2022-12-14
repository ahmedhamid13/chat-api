# frozen_string_literal: true

class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :number, null: false
      t.integer :messages_count, default: 0
      t.references :system_application, foreign_key: true

      t.index %i[number system_application_id], unique: true
      t.timestamps
    end
  end
end
