# frozen_string_literal: true

class CreateSystemApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :system_applications do |t|
      t.string :name, null: false
      t.string :token, null: false, unique: true, index: true
      t.integer :chats_count, default: 0

      t.timestamps
    end
  end
end
