class CreatePairings < ActiveRecord::Migration
  def change
    create_table :pairings do |t|
      t.intger :user_id
      t.integer :pair_id
      t.integer :match_id

      t.timestamps null: false
    end
  end
end
