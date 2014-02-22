class Participant < ActiveRecord::Base
  has_many :results
  has_many :squares
  accepts_nested_attributes_for :squares, :reject_if => :all_blank, :allow_destroy => true
  validates_presence_of :name
end
