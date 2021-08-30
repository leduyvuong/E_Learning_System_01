class CategoriesController < ApplicationController
  before_action :found_category, only: :show
  def index
    @categories = Category.active.search(params[:name]).paginate(page: ( params[:page] if is_number? params[:page] ))
  end
  def show
    @categoriess = Category.all
    @users = parse_data_user(User.group(:role).count)
    respond_to do |format|
      format.html
      format.pdf do
        render template: "categories/show.html.erb",
          pdf: "abc"
      end
     
    end
  end
  private
    def found_category
      @categories = Category.find_by(id: params[:id])
      return @categories unless @categories.nil?
      flash[:danger] = t("categories.inform.not_found")
      redirect_to categories_path
    end 
end
