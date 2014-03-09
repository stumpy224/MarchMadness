class Participant < ActiveRecord::Base
  has_many :results
  has_many :participant_squares
  has_many :squares, through: :participant_squares
  accepts_nested_attributes_for :participant_squares, reject_if: :all_blank, allow_destroy: true
  validates_presence_of :name

  def first_name
    self.name.blank? ? '' : self.name.split(' ')[0]
  end

  def last_name
    self.name.blank? ? '' : self.name.split(' ')[1]
  end
end
