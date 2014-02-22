class Payout < ActiveRecord::Base
  validates_presence_of :game_payout, :round, :year
end
