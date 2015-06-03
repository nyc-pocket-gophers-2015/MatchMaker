class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.text    :content
      t.boolean :seen, default: false
      t.text    :link, default: "#"

      t.timestamps
    end
  end
end
