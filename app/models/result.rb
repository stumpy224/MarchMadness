class Result < ActiveRecord::Base
  belongs_to :participant
  validates_presence_of :participant_id, :round, :year
  # add bracket_position_id to view and validates
end
