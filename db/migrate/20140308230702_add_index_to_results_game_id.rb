class AddIndexToResultsGameId < ActiveRecord::Migration
  def change
    add_index :results, :game_id
  end
end
