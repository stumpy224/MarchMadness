class AddIndexToParticipantSquaresSquareId < ActiveRecord::Migration
  def change
    add_index :participant_squares, :square_id
  end
end
