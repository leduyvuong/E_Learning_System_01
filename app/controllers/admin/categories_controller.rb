class Admin::CategoriesController < ApplicationController
  before_action :admin_user
  before_action :found_category, only: [:edit, :update, :show, :destroy]
  def index 
    @categories = Category.search(params[:name]).paginate(page: params[:page])
  end
  def edit
  end
  def new
    @category = Category.new 
  end
  
  def create
    @category = Category.new(category_params)
    @category.image.attach(params[:category][:image])
    if @category.save
      flash[:success] = t("inform.success")
      redirect_to admin_categories_path
    else
      render :new
    end
  end
  
  def update
    if params[:category][:image]
      @category.image.attach(params[:category][:image])
    end
    if @category.update(category_params)
      flash[:success] = t("inform.success")
      redirect_to edit_admin_category_path
    else
      render :edit
    end
  end
  def destroy
    if @category.update(status: !@category.status)
      flash[:success] = t("inform.success")
      redirect_to admin_categories_path
    else
      flash[:danger] = flash_errors(@category)
      render redirect_to admin_categories_path
    end
  end
  private
    def found_category
      @category = Category.find_by(id: params[:id])
      return @category unless @category.nil?
      flash[:danger] = t("admin.categories.not_found")
      redirect_to admin_categories_path
    end
    def category_params
      params.require(:category).permit(:name, :decription)
    end
end