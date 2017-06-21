class PurcharsesController < ApplicationController
  before_action :set_purcharse, only: [:show, :edit, :update, :destroy]

  # GET /purcharses
  # GET /purcharses.json
  def index
    @purcharses = Purcharse.all
  end

  # GET /purcharses/1
  # GET /purcharses/1.json
  def show
  end

  # GET /purcharses/new
  def new
    @purcharse = Purcharse.new
  end

  # GET /purcharses/1/edit
  def edit
  end

  def addPurcharse
    game_id = params[:game_id]
    user_id = current_user.id
    @purcharse = Purcharse.new
    @purcharse.game_id = game_id
    @purcharse.user_id = user_id
    @purcharse.save
    jsonObject = {"peoplePurcharses" => getPeoplePurcharses(game_id).length}
    respond_to do |format|
      format.html
      format.json { render json: jsonObject }
    end
  end

  def getPeoplePurcharses(game_id)
    @game = Game.find(game_id)
    @purcharses = @game.purcharses
    return @purcharses
  end

  def removePurcharse
    game_id = params[:game_id]
    user_id = current_user.id
    @purcharse = current_user.purcharses.where('game_id = ?', "#{game_id}").first
    Purcharse.destroy(@purcharse.id)
    jsonObject = {"peoplePurcharses" => getPeoplePurcharses(game_id).length}
    respond_to do |format|
      format.html
      format.json { render json: jsonObject }
    end
  end

  # POST /purcharses
  # POST /purcharses.json
  def create
    @purcharse = Purcharse.new(purcharse_params)

    respond_to do |format|
      if @purcharse.save
        format.html { redirect_to @purcharse, notice: 'Purcharse was successfully created.' }
        format.json { render :show, status: :created, location: @purcharse }
      else
        format.html { render :new }
        format.json { render json: @purcharse.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purcharses/1
  # PATCH/PUT /purcharses/1.json
  def update
    respond_to do |format|
      if @purcharse.update(purcharse_params)
        format.html { redirect_to @purcharse, notice: 'Purcharse was successfully updated.' }
        format.json { render :show, status: :ok, location: @purcharse }
      else
        format.html { render :edit }
        format.json { render json: @purcharse.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purcharses/1
  # DELETE /purcharses/1.json
  def destroy
    @purcharse.destroy
    respond_to do |format|
      format.html { redirect_to purcharses_url, notice: 'Purcharse was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purcharse
      @purcharse = Purcharse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purcharse_params
      params.require(:purcharse).permit(:user_id, :game_id)
    end
end
