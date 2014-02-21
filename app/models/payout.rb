class Payout < ActiveRecord::Base
  validates :game_payout, presence: true
  validates :round, presence: true
  validates :year, presence: true
end
