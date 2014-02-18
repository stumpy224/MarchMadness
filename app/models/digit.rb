class Digit < ActiveRecord::Base
  has_and_belongs_to_many :users
  validates :user_id, presence: true
  validates :winner_digit, presence: true
  validates :loser_digit, presence: true
  validates :year, presence: true
end
