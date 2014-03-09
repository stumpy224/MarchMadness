class RemoveYearAndParticipantIdFromSquares < ActiveRecord::Migration
  def change
    remove_column :squares, :year, :string
    remove_column :squares, :participant_id, :integer
  end
end
