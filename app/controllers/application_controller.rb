class ApplicationController < ActionController::Base
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
    $year = get_latest_year if $year.blank?
    url = Year.find_by(year: $year).source_url

    if url.empty?
      return 'Oh, snap! The URL has not been entered for #{$year}.'
    else
      response = Net::HTTP.get_response(URI.parse(url))
    end

    if response.is_a?(Net::HTTPSuccess)
      Game.clean_up
      update_bracket_refreshed_date
      update_results_refreshed_date
      return parse_tourney_response(response)
    else
      handle_failure_response(response)
    end
  end

  def parse_tourney_response(response)
    formatted_response = (response.body.sub! 'callbackWrapper(', '').sub! '});', '}'
    json_response = JSON.parse(formatted_response)
    json_response['games']
  end

  def translate_game_info(game)
    g = Game.new
    g.game_id = game['contestId']
    g.bracket_position_id = game['bracketPositionId']
    g.round = game['round']
    # g.seed_top = game['seedTop']
    # g.seed_bottom = game['seedBottom']
    g.away_name = game['away']['names']['short']
    g.home_name = game['home']['names']['short']

    game['seedTop'] == '' ? g.seed_top = '' : g.seed_top = '(' + game['seedTop'] + ')'
    game['seedBottom'] == '' ? g.seed_bottom = '' : g.seed_bottom = '(' + game['seedBottom'] + ')'
    game['gameState'].upcase == 'FINAL' ? g.game_over = true : g.game_over = false
    game['away']['isTop'] == 'T' ? g.away_is_top = true : g.away_is_top = false
    game['home']['isTop'] == 'T' ? g.home_is_top = true : g.home_is_top = false

    if g.game_over?
      g.home_score = game['home']['score']
      g.away_score = game['away']['score']
      game['home']['winner'] == 'true' ? g.home_is_winner = true : g.home_is_winner = false
      game['away']['winner'] == 'true' ? g.away_is_winner = true : g.away_is_winner = false

      winner_digit = g.home_is_winner? ? g.home_score.to_s.last(1) : g.away_score.to_s.last(1)
      loser_digit = g.home_is_winner? ? g.away_score.to_s.last(1) : g.home_score.to_s.last(1)
      square_id = (("#{winner_digit}#{loser_digit}").to_f + 1).to_i
      participant_square = @@participant_squares.find_by(square_id: square_id, year: $year)

      if participant_square.present?
        participant_winner = @@participants.find(participant_square.participant_id)
        g.square_winner = participant_winner.name
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

  def get_latest_year
    Year.order(:year).last.year
  end

  def handle_failure_response(response)
    if response.message.include?('Not Found')
      return 'Oh, snap! The bracket has not yet been released... please check back later.'
    else
      return 'Oh, snap! An error occurred... please try clicking Refresh again.'
    end
  end
end
