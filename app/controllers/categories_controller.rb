class CategoriesController < ApplicationController
  def home
    @categories = Category.paginate(page: params[:page])
  end
end
