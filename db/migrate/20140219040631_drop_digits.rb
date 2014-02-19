class DropDigits < ActiveRecord::Migration
  def up
    drop_table :digits
  end

  def down
    create_table :digits do |t|
      t.integer :user_id
      t.integer :winner_digit
      t.integer :loser_digit
      t.string :year

      t.timestamps
    end
  end
end
