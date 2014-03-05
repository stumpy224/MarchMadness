class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def access_denied(exception)
    redirect_to admin_organizations_path, :alert => exception.message
  end

  def get_tourney_info
    url = Year.find_by(year: '2013').source_url
    response = Net::HTTP.get_response(URI.parse(url))

    if response.is_a?(Net::HTTPSuccess)
      Game.clean_up
      return parse_tourney_response(response)
    else
      return 'Oh, snap! An error occurred... please try clicking Refresh again to get the latest results.'
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
      loser_digit: game.home_is_winner? ? game.away_score.to_s.last(1) : game.home_score.to_s.last(1)
    )
  end

  def create_new_result_if_necessary(game)
    if game.game_over? and game.round != '1'
      if Result.find_by(round: game.round, year: Time.new.year.to_s, game_id: game.game_id).blank?
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
    year = Year.find_by(year: '2013')
    year.bracket_last_updated_at = DateTime.now
    year.save
  end

  def update_results_refreshed_date
    year = Year.find_by(year: '2013')
    year.results_last_updated_at = DateTime.now
    year.save
  end
end
