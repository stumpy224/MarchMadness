class Year < ActiveRecord::Base
  validates_presence_of :year, :source_url
end
