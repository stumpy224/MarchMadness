class Result < ActiveRecord::Base
  belongs_to :participant
  validates_presence_of :participant_id, :round, :year, :game_id
end
