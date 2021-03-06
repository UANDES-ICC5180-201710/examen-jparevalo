class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @current_user = current_user
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @current_user = current_user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @current_user = current_user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.is_staff = false    # By default
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def toggle_staff
    @user = User.find(params[:user])
    respond_to do |format|
      if current_user.is_staff
        @user.is_staff = !@user.is_staff
        @user.save
        format.html { redirect_to @user, notice: 'User staff property changed succesfully' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render users_path }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if !current_user.is_staff
        format.html { redirect_to users_path, alert: 'Yout must be Staff to edit users.' }
        format.json { render :show, status: :ok, location: @user }
      elsif @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :is_staff)
    end
end
