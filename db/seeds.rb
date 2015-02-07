# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
(0..9).each do |w|
  (0..9).each do |l|
    Square.create( winner_digit: w, loser_digit: l)
  end
end

Year.create(year: "2014", source_url: "http://data.ncaa.com/jsonp/gametool/brackets/championships/basketball-men/d1/2013/data.json", winner_digits: "8,7,2,0,6,5,4,1,9,3", loser_digits: "8,4,2,7,9,1,0,5,3,6")
Year.create(year: "2013", source_url: "http://data.ncaa.com/jsonp/gametool/brackets/championships/basketball-men/d1/2012/data.json", winner_digits: "2,8,4,6,7,0,5,9,3,1", loser_digits: "4,0,2,5,9,8,1,7,3,6")

Participant.create(name: "Jeremiah Stump", display_name: "Stumpy")
Participant.create(name: "Kayla Stump", display_name: "Mrs. Stumpy")

Payout.create(year: "2014", round: "2", game_payout: "5")
Payout.create(year: "2014", round: "3", game_payout: "8")
Payout.create(year: "2014", round: "4", game_payout: "10")
Payout.create(year: "2014", round: "5", game_payout: "15")
Payout.create(year: "2014", round: "6", game_payout: "20")
Payout.create(year: "2014", round: "7", game_payout: "32")

Region.create(year: "2014", name: "West", quadrant_id: "1", style: "top:246px;right:213px;")
Region.create(year: "2014", name: "South", quadrant_id: "2", style: "top:246px;right:218px;")
Region.create(year: "2014", name: "East", quadrant_id: "3", style: "top:230px;right:225px;")
Region.create(year: "2014", name: "Midwest", quadrant_id: "4", style: "top:230px;right:197px;")

AdminUser.create(email: "admin@example.com", password: "password")
