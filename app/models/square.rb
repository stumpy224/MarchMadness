class Square < ActiveRecord::Base
  belongs_to :participant
  validates :winner_digit, presence: true
  validates :loser_digit, presence: true
  validates :year, presence: true
end
