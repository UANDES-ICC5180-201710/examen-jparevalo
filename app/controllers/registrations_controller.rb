class RegistrationsController < Devise::RegistrationsController
 before_action :set_user, only: [:show, :edit, :update, :destroy]

 def new
    @user = User.new
  end

  #AUTOMATIC LOGIN IS DISABLED, REDIRECTS TO LOGIN AFTER SIGN UP
  def create
    @user = User.new(user_params)
    @user.is_staff = false    # By default
    if @user.save
     redirect_to :root, notice: 'User created successfully.'
    else
     render :new
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :is_staff)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

end
