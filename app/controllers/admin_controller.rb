class AdminController < ApplicationController
  before_action :admin_user
  def new
  end
  def admin_user
    redirect_to(home_url) unless current_user.admin?
  end
end
