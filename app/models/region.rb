class Region < ActiveRecord::Base
  validates_presence_of :name, :year, :quadrant_id
end
