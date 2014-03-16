class AddLoserDigitsToYears < ActiveRecord::Migration
  def change
    add_column :years, :loser_digits, :string
  end
end
