class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index

    @current_user = current_user
    if !params[:search].nil?
      @games = (Game.where("title like ?", "%#{params[:search]}%").order('title ASC'))
    else
      @games = Game.all
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @current_user = current_user
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
    @current_user = current_user
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if !current_user.is_staff
        format.html { redirect_to games_path, alert: 'Yout must be Staff to edit games.' }
        format.json { render :show, status: :ok, location: @game }
      elsif @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    respond_to do |format|
      if !current_user.is_staff
        format.html { redirect_to games_path, alert: 'Yout must be Staff to delete games.' }
        format.json { render :show, status: :ok, location: @game }
      else
        @game.destroy
        format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:title, :description, :image_url)
    end
end
