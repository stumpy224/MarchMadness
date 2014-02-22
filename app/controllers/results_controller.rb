class ResultsController < ApplicationController
  before_action :set_result, only: [:show, :edit, :update, :destroy]
  http_basic_authenticate_with :name => "stumpy224", :password => "sochi2014", :only => [:create, :edit, :destroy]

  # GET /results
  # GET /results.json
  def index
    @jsonResponse = parse_json
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.find(params[:id])
      @participant = Participant.find(@result.participant_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def result_params
      params.require(:result).permit(:participant_id, :round, :year)
    end

    def parse_json
      sample_response = '{
          "games": [
    {
          "contestId":"302606",
          "bracketPositionId":"602",
          "away": {
            
                "score":"56",
                "names": {
                  "full": "Syracuse University",
                  "short": "Syracuse",
                  "seo": "syracuse",
                  "char6": "SYR",
                  "char8": "",
                  "char10": ""
                },
                "description":"",
                "iconURL":"/sites/default/files/images/logos/schools/s/syracuse.70.png",
                "radioUrl":"",
                "isTop":"F",
                "winner":"false"
              
          },
          "currentPeriod":"Final",
          "finalMessage":"Final",
          "gameDate": "SATURDAY , APRIL    06",
          "gameDateShort": "APR. 06",
          "startTime":"09:21PM ET",
          "startTimeShort":"09:21P.M.",
          "startTimeEpoch":"1365283260",
          "gameState":"final",
          "home": {
            
                "score":"61",
                "names": {
                  "full": "University of Michigan",
                  "short": "Michigan",
                  "seo": "michigan",
                  "char6": "MICH",
                  "char8": "",
                  "char10": ""
                },
                "description":"",
                "iconURL":"/sites/default/files/images/logos/schools/m/michigan.70.png",
                "radioUrl":"",
                "isTop":"T",
                "winner":"true"
              
          },
          "timeclock":"0:00",
          "round":"6",
          "location": "Georgia Dome, Atlanta, Ga.",
          "network":"CBS",
          "url":"/game/basketball-men/d1/2013/04/06/syracuse-michigan",
          "liveStatsEnabled": "0",
          "previewUrl": "",
          "watchLiveUrl":"http://www.ncaa.com/march-madness-live/game/602",
          "gameCenterUrl": "",
          "externalStatsUrl": "",
          "liveVideoExternalUrl": "",
          "nationalRadioUrl": "",
          "boxScoreUrl": "",
          "recapUrl": "http://www.ncaa.com/game/basketball-men/d1/2013/04/06/syracuse-michigan#recap",
          "highlightUrl":"http://www.ncaa.com/menshighlights/game/602",
          "ticketsUrl":"",
          "seedTop": "4",
          "seedBottom": "4",
          "textOverrideTop":null,
          "textOverrideBottom":null
        }
      ,
        {
          "contestId":"302607",
          "bracketPositionId":"701",
          "away": {
            
                "score":"76",
                "names": {
                  "full": "University of Michigan",
                  "short": "Michigan",
                  "seo": "michigan",
                  "char6": "MICH",
                  "char8": "",
                  "char10": ""
                },
                "description":"(31-8)",
                "iconURL":"/sites/default/files/images/logos/schools/m/michigan.70.png",
                "radioUrl":"",
                "isTop":"F",
                "winner":"false"
              
          },
          "currentPeriod":"Final",
          "finalMessage":"Final",
          "gameDate": "MONDAY   , APRIL    08",
          "gameDateShort": "APR. 08",
          "startTime":"09:23PM ET",
          "startTimeShort":"09:23P.M.",
          "startTimeEpoch":"1365456180",
          "gameState":"final",
          "home": {
            
                "score":"82",
                "names": {
                  "full": "University of Louisville",
                  "short": "Louisville",
                  "seo": "louisville",
                  "char6": "LOUIS",
                  "char8": "",
                  "char10": ""
                },
                "description":"(35-5)",
                "iconURL":"/sites/default/files/images/logos/schools/l/louisville.70.png",
                "radioUrl":"",
                "isTop":"T",
                "winner":"true"
              
          },
          "timeclock":"0:00",
          "round":"7",
          "location": "Georgia Dome, Atlanta, Ga.",
          "network":"CBS",
          "url":"/game/basketball-men/d1/2013/04/08/michigan-louisville",
          "liveStatsEnabled": "1",
          "previewUrl": "",
          "watchLiveUrl":"http://www.ncaa.com/march-madness-live/game/701",
          "gameCenterUrl": "",
          "externalStatsUrl": "",
          "liveVideoExternalUrl": "",
          "nationalRadioUrl": "",
          "boxScoreUrl": "",
          "recapUrl": "http://www.ncaa.com/game/basketball-men/d1/2013/04/08/michigan-louisville",
          "highlightUrl":"http://www.ncaa.com/menshighlights/game/701",
          "ticketsUrl":"",
          "seedTop": "1",
          "seedBottom": "4",
          "textOverrideTop":null,
          "textOverrideBottom":null
        }
          ]
        }'

      parse_result = JSON.parse(sample_response)

      output = " "

      parse_result.each do |game|
        output = game["contestId"]
      end
    end
end
