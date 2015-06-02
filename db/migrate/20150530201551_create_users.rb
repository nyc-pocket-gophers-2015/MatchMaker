class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :name, null: false
      t.date   :birthday
      t.string :gender, null: false
      t.string :location
      t.string :picture_url
      t.text   :bio
      t.string :preferred_gender
      t.integer :preferred_age_low, default: 18
      t.integer :preferred_age_high, default: 100

      t.timestamps null: false
    end
  end
end
