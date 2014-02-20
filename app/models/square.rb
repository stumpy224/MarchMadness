class Square < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :winner_digit, presence: true
  validates :loser_digit, presence: true
  validates :year, presence: true
end
