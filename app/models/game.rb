class Game
  attr_accessor(:winner_digit, :loser_digit, :round, :bracket_position_id)

  def initialize(attributes = {})
    @winner_digit = attributes[:winner_digit]
    @loser_digit = attributes[:loser_digit]
    @round = attributes[:round]
    @bracket_position_id = attributes[:bracket_position_id]
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
