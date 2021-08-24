class UsersController < ApplicationController
  before_action :found_user, only: [:show, :following, :followers, :edit, :update]
  
  def index
    @user = User.all.paginate(page: params[:page])
  end

  def show 
    @summary = Summary.new
    @summary_list = @user.summaries.summary_active
    @categories = @user.categories
    id_array = @user.following_ids
    id_array << @user.id
    id_array.join(", ")
    @activities = User.get_activites(id_array)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save  
      @user.create_user_profile(fullname: @user.username)
      log_in @user
      redirect_to home_path
    else
      render :new
    end
  end

  def edit
    @user_profile = @user.user_profile
  end

  def update
    @user_profile = @user.user_profile
    if params[:user][:image]
      @user_profile.image.attach(params[:user][:image])
    end
    if @user.update(user_params) && @user_profile.update(user_profile_params)
      flash[:success] = t("inform.success")
      redirect_to request.referer
    else
      render :edit
    end
  end
  
  def following
    @users = @user.following.paginate(page: params[:page])
    render :show_follow
  end
  
  def followers
    @users = @user.followers.paginate(page: params[:page])
    render :show_follow
  end
  private

    def user_params
      params.require(:user).permit(:username, :email, :password,
                                  :password_confirmation)
    end

    def found_user
      @user = User.find_by(id: session[:user_id])
      return @user unless @user.nil?
      flash[:danger] = t("errors.not_login")
      redirect_to root_path
    end

    def user_profile_params
      params.require(:user).permit(:fullname, :sex, :address,
                                    :phone, :image)
    end
end