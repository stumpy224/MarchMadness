class AddIndexToSquaresParticipantId < ActiveRecord::Migration
  def change
    add_index :squares, :participant_id
  end
end
