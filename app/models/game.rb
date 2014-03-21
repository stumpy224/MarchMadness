class Game
  attr_accessor(
    :game_id,
    :bracket_position_id,
    :game_state,
    :game_is_live,
    :game_over,
    :round,
    :team_on_top_seed,
    :team_on_top_name_short,
    :team_on_top_name_full,
    :team_on_top_score,
    :team_on_top_is_winner,
    :team_on_bottom_seed,
    :team_on_bottom_name_short,
    :team_on_bottom_name_full,
    :team_on_bottom_score,
    :team_on_bottom_is_winner,
    :square_winner,
    :square_winner_id,
    :current_period,
    :time_clock,
    :network,
    :game_status
  )

  def initialize(attributes = {})
    @game_id = attributes[:game_id]
    @bracket_position_id = attributes[:bracket_position_id]
    @game_state = attributes[:game_state]
    @game_is_live = attributes[:game_is_live]
    @game_over = attributes[:game_over]
    @round = attributes[:round]
    @team_on_top_seed = attributes[:team_on_top_seed]
    @team_on_top_name_short = attributes[:team_on_top_name_short]
    @team_on_top_name_full = attributes[:team_on_top_name_full]
    @team_on_top_score = attributes[:team_on_top_score]
    @team_on_top_is_winner = attributes[:team_on_top_is_winner]
    @team_on_bottom_seed = attributes[:team_on_bottom_seed]
    @team_on_bottom_name_short = attributes[:team_on_bottom_name_short]
    @team_on_bottom_name_full = attributes[:team_on_bottom_name_full]
    @team_on_bottom_score = attributes[:team_on_bottom_score]
    @team_on_bottom_is_winner = attributes[:team_on_bottom_is_winner]
    @square_winner = attributes[:square_winner]
    @square_winner_id = attributes[:square_winner_id]
    @current_period = attributes[:current_period]
    @time_clock = attributes[:time_clock]
    @network = attributes[:network]
    @game_status = attributes[:game_status]
  end

  def game_is_live?
    !!@game_is_live
  end

  def game_over?
    !!@game_over
  end

  def team_on_bottom_is_winner?
    !!@team_on_bottom_is_winner
  end

  def team_on_top_is_winner?
    !!@team_on_top_is_winner
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
