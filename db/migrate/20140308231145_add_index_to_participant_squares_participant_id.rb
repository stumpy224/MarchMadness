class AddIndexToParticipantSquaresParticipantId < ActiveRecord::Migration
  def change
    add_index :participant_squares, :participant_id
  end
end
