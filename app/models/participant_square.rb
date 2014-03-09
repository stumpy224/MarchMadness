class ParticipantSquare < ActiveRecord::Base
  belongs_to :participant
  belongs_to :square
  validates_presence_of :participant_id, :square_id, :year
end
