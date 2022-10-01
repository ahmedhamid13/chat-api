# frozen_string_literal: true

class AddLockVersionToChats < ActiveRecord::Migration[5.2]
  def change
    add_column :chats, :lock_version, :integer, null: false, default: 0
  end
end
