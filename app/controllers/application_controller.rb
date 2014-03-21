class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception

  @@participants = Participant.all
  @@squares = Square.all
  @@participant_squares = ParticipantSquare.all
  @@results = Result.all

  def self.participants
    @@participants
  end

  def self.squares
    @@squares
  end

  def self.participant_squares
    @@participant_squares
  end

  def self.results
    @@results
  end

  def access_denied(exception)
    redirect_to admin_organizations_path, :alert => exception.message
  end

  def get_tourney_info
    Game.clean_up
    $year = get_latest_year if $year.blank?
    url = Year.find_by(year: $year).source_url

    if url.empty?
      return "Oh, snap! The URL has not been entered for #{$year}."
    else
      response = Net::HTTP.get_response(URI.parse(url))
    end

    if response.is_a?(Net::HTTPSuccess)
      update_bracket_refreshed_date
      update_results_refreshed_date
      return parse_tourney_response(response)
    else
      handle_failure_response(response)
    end
  end

  def parse_tourney_response(response)
    # file = File.open('fakeResponse.txt', 'rb')
    # formatted_response = (file.read.sub! 'callbackWrapper(', '').sub! '});', '}'
    # file.close

    formatted_response = (response.body.sub! 'callbackWrapper(', '').sub! '});', '}'
    json_response = JSON.parse(formatted_response)
    json_response['games']
  end

  def translate_game_info(game)
    g = Game.new
    g.game_id = game['contestId']
    g.bracket_position_id = game['bracketPositionId']
    g.round = game['round']
    g.game_state = game['gameState'].upcase
    g.network = game['network']
    
    game['seedTop'] == '' ? g.team_on_top_seed = '' : g.team_on_top_seed = game['seedTop']
    game['seedBottom'] == '' ? g.team_on_bottom_seed = '' : g.team_on_bottom_seed = game['seedBottom']

    if game['away']['isTop'].upcase == 'F' or game['home']['isTop'].upcase == 'T'
      g.team_on_bottom_name_short = game['away']['names']['short']
      g.team_on_bottom_name_full = game['away']['names']['full']
      g.team_on_bottom_score = game['away']['score']
      game['away']['winner'] == 'true' ? g.team_on_bottom_is_winner = true : g.team_on_bottom_is_winner = false

      g.team_on_top_name_short = game['home']['names']['short']
      g.team_on_top_name_full = game['home']['names']['full']
      g.team_on_top_score = game['home']['score']
      game['home']['winner'] == 'true' ? g.team_on_top_is_winner = true : g.team_on_top_is_winner = false
    else
      g.team_on_bottom_name_short = game['home']['names']['short']
      g.team_on_bottom_name_full = game['home']['names']['full']
      g.team_on_bottom_score = game['home']['score']
      game['home']['winner'] == 'true' ? g.team_on_bottom_is_winner = true : g.team_on_bottom_is_winner = false

      g.team_on_top_name_short = game['away']['names']['short']
      g.team_on_top_name_full = game['away']['names']['full']
      g.team_on_top_score = game['away']['score']
      game['away']['winner'] == 'true' ? g.team_on_top_is_winner = true : g.team_on_top_is_winner = false
    end

    g.game_state == 'LIVE' ? g.game_is_live = true : g.game_is_live = false
    g.game_state == 'FINAL' ? g.game_over = true : g.game_over = false
    
    if g.game_is_live?
      g.current_period = game['currentPeriod']
      g.time_clock = game['timeclock']

      if g.current_period == '1st' and g.time_clock == '0:00'
        g.game_status = "Halftime | #{g.network}"
      else
        g.game_status = "#{g.time_clock} #{g.current_period} | #{g.network}"
      end
    end

    if g.game_over?
      winner_digit = g.team_on_top_is_winner? ? g.team_on_top_score.to_s.last(1) : g.team_on_bottom_score.to_s.last(1)
      loser_digit = g.team_on_top_is_winner? ? g.team_on_bottom_score.to_s.last(1) : g.team_on_top_score.to_s.last(1)
      square_id = (("#{winner_digit}#{loser_digit}").to_f + 1).to_i
      participant_square = @@participant_squares.find_by(square_id: square_id, year: $year)

      if participant_square.present?
        participant_winner = @@participants.find(participant_square.participant_id)
        g.square_winner = participant_winner.preferred_name
        g.square_winner_id = participant_winner.id
      else
        g.square_winner = ''
      end
    end

    return g
  end

  def create_new_result_if_necessary(game)
    if @@results.find_by(game_id: game.game_id).blank?
      create_new_result(game)
    end
  end

  def create_new_result(game)
    if not game.square_winner_id.blank?
      Result.create!(
        participant_id: game.square_winner_id,
        round: game.round,
        year: $year,
        game_id: game.game_id)
    end
  end

  def update_bracket_refreshed_date
    year = Year.find_by(year: $year)
    year.bracket_last_updated_at = DateTime.now
    year.save
  end

  def update_results_refreshed_date
    year = Year.find_by(year: $year)
    year.results_last_updated_at = DateTime.now
    year.save
  end

  def handle_failure_response(response)
    if response.message.include?('Not Found')
      return 'Oh, snap! The bracket has not yet been released... please check back later.'
    else
      return 'Oh, snap! An error occurred... please try clicking Refresh again.'
    end
  end
end
