class Game
  attr_accessor(
    :game_id,
    :bracket_position_id,
    :game_over,
    :round,
    :home_is_top,
    :home_name,
    :home_score,
    :home_is_winner,
    :away_is_top,
    :away_name,
    :away_score,
    :away_is_winner,
    :seed_top,
    :seed_bottom,
    :square_winner
  )

  def initialize(attributes = {})
    @game_id = attributes[:game_id]
    @bracket_position_id = attributes[:bracket_position_id]
    @game_over = attributes[:game_over]
    @winner_score = attributes[:winner_score]
    @loser_score = attributes[:loser_score]
    @round = attributes[:round]
    @home_is_top = attributes[:home_is_top]
    @home_name = attributes[:home_name]
    @home_score = attributes[:home_score]
    @home_is_winner = attributes[:home_is_winner]
    @away_is_top = attributes[:away_is_top]
    @away_name = attributes[:away_name]
    @away_score = attributes[:away_score]
    @away_is_winner = attributes[:away_is_winner]
    @seed_top = attributes[:seed_top]
    @seed_bottom = attributes[:seed_bottom]
    @square_winner = attributes[:square_winner]
  end

  def game_over?
    !!game_over
  end

  def home_is_top?
    !!home_is_top
  end

  def home_is_winner?
    !!home_is_winner
  end

  def away_is_top?
    !!away_is_top
  end

  def away_is_winner?
    !!away_is_winner
  end

  def self.exists?
    self.count > 0 ? true : false
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
