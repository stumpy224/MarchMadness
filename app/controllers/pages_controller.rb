require 'net/http'

class PagesController < ApplicationController
  def bracket
    get_tourney_games if !Game.exists?
    @games = Game.all
  end

  def results
    @participants = Participant.all.order(:name)
    @payouts = Payout.all
  end

  def refresh_bracket
    redirect_to action: 'bracket'
    get_tourney_games
  end

  def refresh_results
    redirect_to action: 'results'
    get_tourney_games
  end

  def grid
    @squares = Square.all.order(winner_digit: :asc, loser_digit: :asc)
    @participants = Participant.all
  end

  private

    def get_tourney_games
      tourney_games = get_tourney_info
      if tourney_games.include?("Oh, snap! An error occurred...")
        flash[:error] = tourney_games
      else
        tourney_games.each do |g|
          game = translate_game_info(g)
          create_new_result_if_necessary(game)
        end
      end
    end
end
