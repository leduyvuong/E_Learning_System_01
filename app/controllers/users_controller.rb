class UsersController < ApplicationController
  before_action :found_user, only: [:show, :edit, :update]
  before_action :current_user, only: [:edit_summary]
  def found_user
    @user = User.find_by(id: session[:user_id])
    if @user
      return @user
    else
      flash[:danger] = t('errors.not_login')
      redirect_to login_path
    end
  end
  def show 
    @categories = @user.categories      
  end
  def edit
  end
  def update 
    @user.user_profile.image.attach(params[:user][:image])
    if @user.update(user_params) && @user.user_profile.update(user_profile_params)
      flash[:success] = 'Update successful'
      redirect_to edit_path
    else
      render "edit"
    end
  end
  def new
    @user =User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save &&  @user.create_user_profile(fullname: @user.username)
      log_in @user
      redirect_to home_path
    else
      render :new
    end
  end
  private
    def user_params
      params.require(:user).permit(:username, :email, :password,
                                  :password_confirmation)
    end
    def user_profile_params
      params.require(:user).permit(:fullname, :sex, :address,
                                    :phone, :image)
    end
end
