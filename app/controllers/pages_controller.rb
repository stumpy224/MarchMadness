require 'net/http'

class PagesController < ApplicationController
  respond_to :html, :xml, :json, :js

  def bracket
    get_tourney_games if !Game.exists?
    @games = Game.all
    @regions = Region.all
    @years = Year.all

    respond_with(@games)
  end

  def results
    if params[:year].present?
      $year = params[:year]
    else
      $year = get_latest_year
    end

    @participant_squares = ParticipantSquare.all
    @participants_with_squares = ParticipantSquare.select(:participant_id).distinct\
      .where(year: $year).group(:participant_id).page(params[:page]).per(10)
    @payouts = Payout.all
    @results = Result.all
    @years = Year.all

    respond_with(@participants_with_squares)
  end

  def refresh_bracket
    redirect_to action: 'bracket'
    get_tourney_games
  end

  def refresh_results
    redirect_to action: 'results', year: $year
    get_tourney_games
  end

  def grid
    @squares = Square.order(winner_digit: :asc, loser_digit: :asc)
    @participant_squares = ParticipantSquare.where(year: $year).select(:participant_id)
    @participants = Participant.all
  end

  private

    def get_tourney_games
      tourney_games = get_tourney_info
      
      if tourney_games.include?('Oh, snap!')
        flash.now[:error] = tourney_games
      else
        tourney_games.each do |g|
          game = translate_game_info(g)
          create_new_result_if_necessary(game) if (game.game_over? and game.round != '1')
        end
      end
    end

    def person_params
      params.permit(:year, :refresh)
    end
end
