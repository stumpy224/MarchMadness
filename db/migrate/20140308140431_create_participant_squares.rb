class CreateParticipantSquares < ActiveRecord::Migration
  def change
    create_table :participant_squares do |t|
      t.integer :participant_id
      t.integer :square_id
      t.string :year

      t.timestamps
    end
  end
end
