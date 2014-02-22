class Square < ActiveRecord::Base
  belongs_to :participant
  validates_presence_of :winner_digit, :loser_digit, :year, :participant_id
end
