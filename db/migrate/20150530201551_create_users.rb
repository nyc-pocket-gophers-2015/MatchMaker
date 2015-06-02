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
<<<<<<< HEAD
      t.string :preferred_gender, null: false
      t.integer :preferred_age_low, default: 18
      t.integer :preferred_age_high, default: 100
=======
      t.string :preferred_gender
      t.integer :preferred_age_low
      t.integer :preferred_age_high
>>>>>>> sets up facebook login and user creation with facebook

      t.timestamps null: false
    end
  end
end
