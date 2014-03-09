class RemoveIndexFromSquaresLoserDigit < ActiveRecord::Migration
  def change
    remove_index :squares, :loser_digit
  end
end
