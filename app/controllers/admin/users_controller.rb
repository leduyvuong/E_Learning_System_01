class Admin::UsersController < ApplicationController
  before_action :admin_user
  before_action :found_user, only: [:edit, :update,:destroy, :show]
  def index 
    @users = User.search(params[:name]).paginate(page: ( params[:page] if is_number? params[:page] ))
  end
  def new
    @user = User.new
  end
  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.create_user_profile(fullname: @user.username)
      flash[:success] = t("inform.success")
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def edit
    @user_profile = @user.user_profile
  end

  def update
    @user_profile = @user.user_profile
    @user_profile.image.attach(params[:user][:image])
    if @user.update(user_params)
      @user_profile.update(user_profile_params)
      flash[:success] = t("inform.success")
      render :edit
    else
      render :edit
    end
  end

  def destroy
    if @user.update(status: !@user.status)
      flash[:success] = t("inform.success")
      redirect_to admin_users_path
    else
      flash[:danger] = flash_errors(@user)
      render redirect_to admin_users_path
    end
  end

  private
    def user_params
      user_param = params.require(:user).permit(:username, :email, :password,
                                  :password_confirmation, :role, :status)
      
    end
    def user_profile_params
      params.require(:user).permit(:fullname, :sex, :address,
                                    :phone, :image)
    end
    def found_user
      @user = User.find_by(id: params[:id])
      return @user unless @user.nil?
      flash[:danger] = t("errors.not_found_user")
      redirect_to admin_users_path
    end 
end