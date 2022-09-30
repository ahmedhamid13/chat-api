class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :number
      t.integer :messages_count, default: 0
      t.references :system_application, foreign_key: true

      t.timestamps
    end
  end
end
