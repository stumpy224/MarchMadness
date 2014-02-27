class RenameColumnBracketPositionIdToGameId < ActiveRecord::Migration
  def change
    rename_column :results, :bracket_position_id, :game_id
  end
end
