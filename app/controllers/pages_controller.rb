require 'net/http'

class PagesController < ApplicationController
  def bracket
    if !Game.exists?
      get_tourney_games
      update_bracket_refreshed_date
    end
    
    @games = Game.all
  end

  def results
    if params[:year].present?
      $year = params[:year]
    else
      $year = Year.order(:year).last.year
    end

    @participants = Participant.joins('INNER JOIN squares '\
      'ON squares.participant_id = participants.id '\
      'WHERE squares.year = ' + $year).order(:name)
    @payouts = Payout.all
  end

  def refresh_bracket
    redirect_to action: 'bracket'
    get_tourney_games
    update_bracket_refreshed_date
  end

  def refresh_results
    redirect_to controller: 'pages', action: 'results', year: $year
    get_tourney_games
    update_results_refreshed_date
  end

  def grid
    @squares = Square.where(year: $year).order(winner_digit: :asc, loser_digit: :asc)
    @participants = Participant.all
  end

  private

    def get_tourney_games
      tourney_games = get_tourney_info

'Response does not contain any data.' if response.include?

      return 'Oh, snap! An error occurred... please try clicking Refresh again to get the latest results.'


      if tourney_games.include?('Oh, snap! An error occurred...')
        flash.now[:error] = tourney_games
      else
        tourney_games.each do |g|
          game = translate_game_info(g)
          create_new_result_if_necessary(game)
        end
      end
    end
end
