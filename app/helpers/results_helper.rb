module ResultsHelper
  def get_tourney_info
    url = 'http://data.ncaa.com/jsonp/gametool/brackets/championships/basketball-men/d1/2012/data.json'
    Net::HTTP.get_response(URI.parse(url))
  end

  def parse_tourney_json(response)
    formatted_response = (response.body.sub! 'callbackWrapper(', '').sub! '});', '}'
    json_response = JSON.parse(formatted_response)
    json_response['games']
  end

  def translate_game_info(parsed_game)
    game = Game.new
    game.game_id = parsed_game['contestId']
    game.bracket_position_id = parsed_game['bracketPositionId']
    game.game_state = parsed_game['gameState']
    game.round = parsed_game['round']

    if parsed_game['away']['winner'] == "true"
      game.winner_score = parsed_game['away']['score']
      game.loser_score = parsed_game['home']['score']
    else
      game.winner_score = parsed_game['home']['score']
      game.loser_score = parsed_game['away']['score']
    end

    return game
  end

  def create_new_result(game, square)
    Result.create(
      participant_id: square.participant_id,
      round: game.round,
      year: square.year,
      game_id: game.game_id)
  end
end
