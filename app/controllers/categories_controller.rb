class CategoriesController < ApplicationController
  before_action :found_category, only: :show
  def index
    if params[:name].nil?
      @categories = Category.active.paginate(page: ( params[:page] if is_number? params[:page] ) )
    else
      if params[:name] == "" 
        @categories = Category.active.paginate(page: ( params[:page] if is_number? params[:page] ) )
      else
        @categories = Category.active.search(params[:name],page: params[:page], per_page: Settings.WillPaginate.cate_per_page )
      end
    end
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
