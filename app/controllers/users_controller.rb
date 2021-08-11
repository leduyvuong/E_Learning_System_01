class UsersController < ApplicationController
  before_action :found_user, only: [:show, :edit, :update, :following, :followers, :activities]

  def index
    @user = User.all.paginate(page: params[:page])
  end
  def show 
    @categories = @user.categories 
    @user_f = @user.following.ids
    begin
      @activities = ActiveRecord::Base.connection.exec_query("select u.username, w.created_at, c.name from wordlists w 
        inner join users u on u.id = w.user_id and w.user_id in (#{ @user_f.map(&:inspect).join(", ")}) 
        inner join categories c on c.id = w.category_id order by  w.created_at desc").to_a
    rescue
      return @categories && @activities = nil
    else
      return @activities.to_a && @categories
    end   
  end
  def logged_in_user
    unless logged_in?
        flash[:danger] = t('errors.not_login')
        redirect_to login_url
    end
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
    @user = User.new
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
    def user_profile_params
      params.require(:user).permit(:fullname, :sex, :address,
                                    :phone, :image)
    end
    def found_user
      @user = User.find_by(id: session[:user_id])
      if @user
        return @user
      else
        flash[:danger] = t('errors.not_login')
        redirect_to login_path
      end
    end   
end
