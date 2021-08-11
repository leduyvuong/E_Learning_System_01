class Admin::CategoriesController < ApplicationController
  before_action :admin_user
  def index 
    @categories = Category.paginate(page: params[:page])
  end
end
