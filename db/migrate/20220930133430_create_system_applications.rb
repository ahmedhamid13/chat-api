class CreateSystemApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :system_applications do |t|
      t.string :name
      t.string :token
      t.integer :chats_count

      t.timestamps
    end
  end
end
