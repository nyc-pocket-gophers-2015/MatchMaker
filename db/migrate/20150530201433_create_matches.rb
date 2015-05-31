class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :user_id, null: false
      t.integer :matcher_id, default: nil

      t.timestamps null: false
    end
  end
end
