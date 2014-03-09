class RemoveIndexFromSquaresWinnerDigit < ActiveRecord::Migration
  def change
    remove_index :squares, :winner_digit
  end
end
