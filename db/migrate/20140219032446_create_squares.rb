class CreateSquares < ActiveRecord::Migration
  def change
    create_table :squares do |t|
      t.integer :user_id
      t.integer :winner_digit
      t.integer :loser_digit
      t.string :year

      t.timestamps
    end
  end
end
