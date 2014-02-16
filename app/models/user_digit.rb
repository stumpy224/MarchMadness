class UserDigit < ActiveRecord::Base
	validates :user_id, presence: true
	validates :winner_digit, presence: true
	validates :loser_digit, presence: true
	validates :year, presence: true
end
