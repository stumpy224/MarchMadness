require 'net/http'

class PagesController < ApplicationController
  include ResultsHelper

  def bracket
  end

  def get_bracket
    @games
    redirect_to action: 'bracket'

    response = get_tourney_info
    if response.is_a?(Net::HTTPSuccess)
      Game.clean_up
      parse_tourney_json(response).each do |parsed_game|
        game = translate_game_info(parsed_game)
        if game.game_state.upcase == "FINAL"
          @games << game
        end
      end
    else
      flash[:error] = "An error occurred.  Please try clicking Refresh again to get the latest results."
    end
  end
end
