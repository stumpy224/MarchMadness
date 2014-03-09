class AddIndexToSquaresLoserDigit < ActiveRecord::Migration
  def change
    add_index :squares, :loser_digit
  end
end
