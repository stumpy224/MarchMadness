class AddBracketPositionIdToResults < ActiveRecord::Migration
  def change
    add_column :results, :bracket_position_id, :integer
  end
end
