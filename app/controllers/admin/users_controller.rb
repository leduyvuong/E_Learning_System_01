class Admin::UsersController < ApplicationController
  def index 
    @users = User.all.paginate(page: params[:page])
  end
end
