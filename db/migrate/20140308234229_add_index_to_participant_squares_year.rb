class AddIndexToParticipantSquaresYear < ActiveRecord::Migration
  def change
    add_index :participant_squares, :year
  end
end
