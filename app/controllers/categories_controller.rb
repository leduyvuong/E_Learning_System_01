class CategoriesController < ApplicationController
  before_action :found_category, only: :show
  def index
    @categories = Category.active.search(params[:name]).paginate(page: params[:page])
    render :home
  end
  def show
  end
  private
    def found_category
      @categories = Category.find_by(id: params[:id])
      return @categories unless @categories.nil?
      flash[:danger] = t("categories.inform.not_found")
      redirect_to categories_path
    end 
end
