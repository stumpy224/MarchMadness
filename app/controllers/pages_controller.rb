class PagesController < ApplicationController
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
