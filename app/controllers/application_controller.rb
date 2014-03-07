class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def access_denied(exception)
    redirect_to admin_organizations_path, :alert => exception.message
  end

  def get_tourney_info
    if $year.blank?
      $year = get_latest_year
    end

    url = Year.find_by(year: $year).source_url

    if url.empty?
      return 'Oh, snap! The URL has not been entered for #{$year}.'
    else
      response = Net::HTTP.get_response(URI.parse(url))
    end

    if response.is_a?(Net::HTTPSuccess)
      Game.clean_up
      return parse_tourney_response(response)
    else
      if response.message.include?('Not Found')
        return 'Oh, snap! The bracket has not yet been released... please check back later.'
      else
        return 'Oh, snap! An error occurred... please try clicking Refresh again.'
      end
    end
  end

  def parse_tourney_response(response)
    formatted_response = (response.body.sub! 'callbackWrapper(', '').sub! '});', '}'
    json_response = JSON.parse(formatted_response)
    json_response['games']
  end

  def translate_game_info(parsed_game)
    game = Game.new
    game.game_id = parsed_game['contestId']
    game.bracket_position_id = parsed_game['bracketPositionId']
    game.round = parsed_game['round']
    parsed_game['gameState'].upcase == 'FINAL' ? game.game_over = true : game.game_over = false

    game.seed_top = parsed_game['seedTop']
    game.seed_bottom = parsed_game['seedBottom']
    parsed_game['away']['isTop'] == 'T' ? game.away_is_top = true : game.away_is_top = false
    parsed_game['home']['isTop'] == 'T' ? game.home_is_top = true : game.home_is_top = false
    game.away_name = parsed_game['away']['names']['short']
    game.home_name = parsed_game['home']['names']['short']

    if game.game_over?
      game.home_score = parsed_game['home']['score']
      game.away_score = parsed_game['away']['score']
      parsed_game['home']['winner'] == 'true' ? game.home_is_winner = true : game.home_is_winner = false
      parsed_game['away']['winner'] == 'true' ? game.away_is_winner = true : game.away_is_winner = false

      square = get_square_by_game(game)

      if square.present?
        game.square_winner = Participant.find(square.participant_id).name
      else
        game.square_winner = ''
      end
    end

    return game
  end

  def get_square_by_game(game)
    Square.find_by(
      winner_digit: game.home_is_winner? ? game.home_score.to_s.last(1) : game.away_score.to_s.last(1),
      loser_digit: game.home_is_winner? ? game.away_score.to_s.last(1) : game.home_score.to_s.last(1),
      year: $year
    )
  end

  def create_new_result_if_necessary(game)
    if game.game_over? and game.round != '1'
      if Result.find_by(round: game.round, year: $year, game_id: game.game_id).blank?
        square = get_square_by_game(game)
        create_new_result game, square if square.present?
      end
    end
  end

  def create_new_result(game, square)
    update_results_refreshed_date
    Result.create(
      participant_id: square.participant_id,
      round: game.round,
      year: square.year,
      game_id: game.game_id)
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
end
