class AddIndexToSquaresWinnerDigit < ActiveRecord::Migration
  def change
    add_index :squares, :winner_digit
  end
end
