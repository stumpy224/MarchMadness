class AddIndexToResultsParticipantId < ActiveRecord::Migration
  def change
    add_index :results, :participant_id
  end
end
