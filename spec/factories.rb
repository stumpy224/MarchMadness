FactoryGirl.define do
  factory :participant do
    name "John Doe"
  end

  factory :square do
    user_id            1
    winner_digit    0
    loser_digit       0
    year                 "2014"
  end
end