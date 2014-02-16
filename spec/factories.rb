FactoryGirl.define do
  factory :user do
    first_name	"Jo"
    last_name	"Dirt"
  end

  factory :user_digit do
  	user_id 1
  	winner_digit 0
  	loser_digit 0
  	year "2014"
  end
end