require 'net/http'

class ResultsController < ApplicationController
  before_action :set_result, only: [:show, :edit, :update, :destroy]
  http_basic_authenticate_with :name => "stumpy224", :password => "sochi2014", :only => [:create, :edit, :destroy]

  helper_method :check_for_results

  # GET /results
  # GET /results.json
  def index
    @participants = Participant.all.order(:name)
    @payouts = Payout.all
    @results = Result.all
  end

  # GET /results/1
  # GET /results/1.json
  def show
  end

  # GET /results/new
  def new
    @result = Result.new
    @participants = Participant.all.order(:name)
  end

  # GET /results/1/edit
  def edit
    @participants = Participant.all.order(:name)
  end

  # POST /results
  # POST /results.json
  def create
    @result = Result.new(result_params)

    respond_to do |format|
      if @result.save
        flash[:success] = "Result created successfully."
        format.html { redirect_to @result }
        format.json { render action: 'show', status: :created, location: @result }
      else
        format.html { render action: 'new' }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /results/1
  # PATCH/PUT /results/1.json
  def update
    respond_to do |format|
      if @result.update(result_params)
        flash[:success] = "Result updated successfully."
        format.html { redirect_to @result }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1
  # DELETE /results/1.json
  def destroy
    @result.destroy
    respond_to do |format|
      format.html { redirect_to results_url }
      format.json { head :no_content }
    end
  end

  def check_for_results
   if get_bracket_response.is_a?(Net::HTTPSuccess)
    parse_json(get_bracket_response).each do |parsed_game|
      if parsed_game['gameState'].upcase == "FINAL"
        game = translate_game_info parsed_game

        if Result.find_by(round: game.round, year: Time.new.year, bracket_position_id: game.bracket_position_id).blank?
          square = Square.find_by winner_digit: game.winner_digit, loser_digit: game.loser_digit

          create_new_result game, square if square.present?
        end
      end
    end
  else
    flash[:notice] = "Please try refreshing the page to get the latest results."
  end
end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.find(params[:id])
      @participant = Participant.find(@result.participant_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def result_params
      params.require(:result).permit(:participant_id, :round, :year, :bracket_position_id)
    end

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
      game.bracket_position_id = parsed_game['bracketPositionId']

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
      result = Result.new do |r|
        r.participant_id = square.participant_id
        r.round = game.round
        r.year = Time.new.year
        r.bracket_position_id = game.bracket_position_id
      end

      result.save
    end
  end
