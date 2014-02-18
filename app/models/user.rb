class User < ActiveRecord::Base
	has_many :digits
	validates :first_name, presence: true
	validates :last_name, presence: true
end
