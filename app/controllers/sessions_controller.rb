class SessionsController < ApplicationController
  def create
    @user = User.where("username = ? or email = ?", params[:session][:username], params[:session][:username]).first
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      redirect_to home_path
    else
      flash.now[:danger] = t('errors.fail_login')
      render 'new'
    end
  end
  def destroy
    log_out
    redirect_to root_url
  end 
  def new
    if logged_in?
    end
  end
end