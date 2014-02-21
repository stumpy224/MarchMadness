class CreatePayouts < ActiveRecord::Migration
  def change
    create_table :payouts do |t|
      t.integer :game_payout
      t.integer :round
      t.string :year

      t.timestamps
    end
  end
end
