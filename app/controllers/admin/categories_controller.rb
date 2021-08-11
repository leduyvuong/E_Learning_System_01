class Admin::CategoriesController < ApplicationController
  before_action :admin_user
  before_action :found_cate, only: [:edit, :update, :show, :destroy]
  def index 
    @categories = Category.paginate(page: params[:page])
  end
  def edit
  end
  def new
    @category = Category.new 
  end
  def show
  end 
  def create
    @category = Category.new(cate_params)
    @category.image.attach(params[:category][:image])
    if @category.save
      flash[:success] = "Add cate successful"
      redirect_to admin_categories_path
    else
      render :new
    end
  end
  
  def update
    if @category.status == true 
      @category.image.attach(params[:category][:image])
      if @category.update(cate_params)
        flash[:success] = "Successfull"
        redirect_to edit_admin_category_path
      else
        render :edit
      end
    else
      if @category.update(status: true)
        flash[:success] = "Active Successfull"
        redirect_to admin_categories_path
      else
        flash[:dange] = flash_errors(@category)
        redirect_to admin_categories_path
      end
    end
  end
  def destroy
    if @category.update(status: false)
      flash[:success] = "Successfull"
      redirect_to admin_categories_path
    else
      flash[:danger] = flash_errors(@category)
      redirect_to admin_categories_path
    end
  end
  private
    def found_cate
      @category = Category.find_by(id: params[:id])
      if @category
        return @category
      else
        flash[:danger] = "Not found!"
        redirect_to admin_categories_path
      end
    end
    def cate_params
      params.require(:category).permit(:name, :decription, :status)
    end
end
