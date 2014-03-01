require 'net/http'

class ResultsController < ApplicationController
  include ResultsHelper

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
    response = get_tourney_info
    if response.is_a?(Net::HTTPSuccess)
      Game.clean_up
      parse_tourney_json(response).each do |parsed_game|
        game = translate_game_info(parsed_game)
        if game.game_state.upcase == "FINAL"
          if Result.find_by(round: game.round, year: Time.new.year, game_id: game.game_id).blank?
            square = Square.find_by(winner_digit: game.winner_score.to_s.last(1), loser_digit: game.loser_score.to_s.last(1))
            create_new_result game, square if square.present?
          end
        end
      end
    else
      flash[:error] = "An error occurred.  Please try clicking Refresh again to get the latest results."
    end
  end
end
