class CreateUserDigits < ActiveRecord::Migration
  def change
    create_table :user_digits do |t|
      t.integer :user_id
      t.integer :winner_digit
      t.integer :loser_digit
      t.string :year

      t.timestamps
    end
  end
end
