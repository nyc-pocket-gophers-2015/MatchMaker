class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text    :content, null: false
      t.integer :user_id, null: false
      t.integer :chat_id, null: false

      t.timestamps null: false
    end
  end
end
