class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to home_path
    end
  end
  def create
    @user = User.where("username = ? or email = ?", params[:session][:username], params[:session][:username]).first
    if @user && @user.valid_password?(params[:session][:password])
      log_in @user
      redirect_to home_path
    else
      flash.now[:danger] = t("errors.fail_login")
      render :new
    end
  end
  def destroy
    log_out
    redirect_to root_url
  end 
end