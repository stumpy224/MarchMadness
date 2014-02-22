class Result < ActiveRecord::Base
  belongs_to :participant
  validates :participant_id, presence: true
  validates :round, presence: true
  validates :year, presence: true
end
