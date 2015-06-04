class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.integer :user_id, null: false
      t.integer :chatter_id, null: false

      t.timestamps null: false
    end
  end
end
