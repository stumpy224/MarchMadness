class ParticipantsController < ApplicationController
  # before_filter :authenticate, :only => [:edit, :update]
  before_action :set_participant, only: [:show, :edit, :update, :destroy]
  http_basic_authenticate_with :name => "stumpy224", :password => "sochi2014", :only => [:create, :edit, :destroy]

  # GET /participants
  # GET /participants.json
  def index
    @participants = Participant.all.order(:name)
  end

  # GET /participants/1
  # GET /participants/1.json
  def show
  end

  # GET /participants/new
  def new
    @participant = Participant.new
  end

  # GET /participants/1/edit
  def edit
  end

  # POST /participants
  # POST /participants.json
  def create
    @participant = Participant.new(participant_params)

    respond_to do |format|
      if @participant.save
        flash[:success] = "Participant created successfully."
        format.html { redirect_to @participant }
        format.json { render action: 'show', status: :created, location: @participant }
      else
        format.html { render action: 'new' }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /participants/1
  # PATCH/PUT /participants/1.json
  def update
    respond_to do |format|
      if @participant.update(participant_params)
        flash[:success] = "Participant updated successfully."
        format.html { redirect_to @participant }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participants/1
  # DELETE /participants/1.json
  def destroy
    @participant.destroy
    respond_to do |format|
      format.html { redirect_to participants_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participant
      @participant = Participant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def participant_params
      params.require(:participant).permit(:name, squares_attributes: [:id, :winner_digit, :loser_digit, :year, :_destroy])
    end
end
