class Game
  attr_accessor(:winner_digit, :loser_digit, :round, :game_id)

  def initialize(attributes = {})
    @winner_digit = attributes[:winner_digit]
    @loser_digit = attributes[:loser_digit]
    @round = attributes[:round]
    @game_id = attributes[:game_id]
  end

  def self.all
    ObjectSpace.each_object(self).to_a
  end

  def self.count
    all.count
  end

  def self.clean_up
    ObjectSpace.garbage_collect
  end
end
