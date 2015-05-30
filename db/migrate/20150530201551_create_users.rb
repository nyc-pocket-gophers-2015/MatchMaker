class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.date   :birthday, null: false
      t.string :gender, null: false
      t.string :location, null: false
      t.string :picture_url
      t.text   :bio
      t.string :password_digest, null: false

      t.timestamps null: false
    end
  end
end
