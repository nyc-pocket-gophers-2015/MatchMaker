class CreatePairings < ActiveRecord::Migration
  def change
    create_table :pairings do |t|
      t.integer :user_id, null: false
      t.integer :pair_id, null: false
      t.integer :match_id

      t.timestamps null: false
    end
  end
end
