require 'net/http'

class ResultsController < ApplicationController
  # GET /results
  # GET /results.json
  def index
    @participants = Participant.all.order(:name)
    @payouts = Payout.all
    @results = Result.all
    if !@results.blank?
      @most_recent_result_date_time = Result.last.updated_at
    end
  end

  def check_for_results
    redirect_to action: 'index'
    
    # if get_bracket_response.is_a?(Net::HTTPSuccess)
    #   parse_json(get_bracket_response).each do |parsed_game|
    #     if parsed_game['gameState'].upcase == "FINAL"
    #       game = translate_game_info(parsed_game)

    #       if Result.find_by(round: game.round, year: Time.new.year, game_id: game.game_id).blank?
    #         square = Square.find_by(winner_digit: game.winner_digit, loser_digit: game.loser_digit)

    #         create_new_result game, square if square.present?
    #       end
    #     end
    #   end
    # else
    #   flash[:error] = "An error occurred.  Please try clicking Refresh again to get the latest results."
    # end
  end

  private
    def get_bracket_response
      url = 'http://data.ncaa.com/jsonp/gametool/brackets/championships/basketball-men/d1/2012/data.json'
      Net::HTTP.get_response(URI.parse(url))
    end

    def parse_json(response)
      formatted_response = (response.body.sub! 'callbackWrapper(', '').sub! '});', '}'
      json_response = JSON.parse(formatted_response)
      json_response['games']
    end

    def translate_game_info(parsed_game)
      Game.clean_up
      game = Game.new
      game.round = parsed_game['round']
      game.game_id = parsed_game['contestId']

      if parsed_game['away']['winner'] == "true"
        game.winner_digit = away_team_score parsed_game
        game.loser_digit = home_team_score parsed_game
      else
        game.winner_digit = home_team_score parsed_game
        game.loser_digit = away_team_score parsed_game
      end

      return game
    end

    def away_team_score(parsed_game)
      parsed_game['away']['score'].last(1)
    end

    def home_team_score(parsed_game)
      parsed_game['home']['score'].last(1)
    end

    def create_new_result(game, square)
      Result.create(
        participant_id: square.participant_id,
        round: game.round,
        year: Time.new.year,
        game_id: game.game_id)
    end
  end
