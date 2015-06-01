class CreateRejectedPairings < ActiveRecord::Migration
  def change
    create_table :rejected_pairings do |t|
      t.integer :user_id, null: false
      t.integer :pairing_id, null: false

      t.timestamps
    end
  end
end
