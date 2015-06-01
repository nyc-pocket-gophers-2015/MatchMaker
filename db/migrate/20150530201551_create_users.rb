class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :name, null: false
      t.date   :birthday, null: false
      t.string :gender, null: false
      t.string :location, null: false
      t.string :picture_url
      t.text   :bio
      t.string :preferred_gender, null: false
      t.integer :preferred_age_low
      t.integer :preferred_age_high

      t.timestamps null: false
    end
  end
end
