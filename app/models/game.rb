class Game
  attr_accessor(:game_id, :bracket_position_id, :game_state, :winner_score, :loser_score, :round)

  def initialize(attributes = {})
    @game_id = attributes[:game_id]
    @bracket_position_id = attributes[:bracket_position_id]
    @game_state = attributes[:game_state]
    @winner_score = attributes[:winner_score]
    @loser_score = attributes[:loser_score]
    @round = attributes[:round]
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
