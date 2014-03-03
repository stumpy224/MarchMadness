require 'net/http'

class PagesController < ApplicationController
  def results
    @participants = Participant.all.order(:name)
    @payouts = Payout.all
    @results = Result.all
    if !@results.blank?
      @most_recent_result_date_time = Result.last.updated_at
    end
  end

  def check_for_results
    redirect_to action: 'results'
    response = get_tourney_info
    if response.is_a?(Net::HTTPSuccess)
      Game.clean_up
      parse_tourney_json(response).each do |parsed_game|
        game = translate_game_info(parsed_game)
        create_new_result_if_necessary(game)
      end
    else
      flash[:error] = "An error occurred.  Please try clicking Refresh again to get the latest results."
    end
  end

  def bracket
    response = get_tourney_info
    if response.is_a?(Net::HTTPSuccess)
      Game.clean_up
      parse_tourney_json(response).each do |parsed_game|
        game = translate_game_info(parsed_game)
        create_new_result_if_necessary(game)
      end

      @games = Game.all
    else
      flash[:error] = "An error occurred.  Please try clicking Refresh again to get the latest results."
    end
  end
end
