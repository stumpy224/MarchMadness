class AddWinnerDigitsToYears < ActiveRecord::Migration
  def change
    add_column :years, :winner_digits, :string
  end
end
