class Square < ActiveRecord::Base
  has_many :participant_squares
  validates_presence_of :winner_digit, :loser_digit
end
