# frozen_string_literal: true

class AddLockVersionToSystemApplication < ActiveRecord::Migration[5.2]
  def change
    add_column :system_applications, :lock_version, :integer, null: false, default: 0
  end
end
