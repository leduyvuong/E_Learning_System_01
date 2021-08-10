class Admin::CategoriesController < ApplicationController
  def index 
    @categories = Category.paginate(page: params[:page])
  end
end
