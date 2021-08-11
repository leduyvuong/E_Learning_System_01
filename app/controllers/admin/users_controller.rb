class Admin::UsersController < ApplicationController
  before_action :admin_user
  before_action :found_user, only: [:edit, :update, :destroy, :show]
  def index 
    @users = User.search(params[:name]).paginate(page: params[:page])
    if @users.count == 0
      @users = User.all.paginate(page: params[:pages])
    else
      @users
    end
  end
  def new
    @user = User.new
  end
  def show
    if @user
      return @user
    else
      return current_user
    end
  end
  def edit   
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Add user Successfull"
      redirect_to admin_users_path
    else
      render :new
    end
  end
  def update 
    @user.user_profile.image.attach(params[:user][:image])
    if @user.update(user_params) && @user.user_profile.update(user_profile_params)
      flash[:success] = "Update successful"
      render :edit
    else
      render :edit
    end
  end

  def destroy
    if @user.update(status: false)
      flash[:success] = "Unactive Successfull"
      redirect_to admin_users_path
    else
      redirect_to admin_users_path
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password,
                                  :password_confirmation, :admin, :status)
    end
    def user_profile_params
      params.require(:user).permit(:fullname, :sex, :address,
                                    :phone, :image)
    end
    def found_user
      @user = User.find_by(id: params[:id])
      if @user
        return @user
      else
        flash[:danger] = t('errors.not_login')
        redirect_to login_path
      end
    end  
end
