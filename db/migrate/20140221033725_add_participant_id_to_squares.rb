class AddParticipantIdToSquares < ActiveRecord::Migration
  def change
    add_column :squares, :participant_id, :integer
  end
end
