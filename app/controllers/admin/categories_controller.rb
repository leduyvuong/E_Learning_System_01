class Admin::CategoriesController < ApplicationController
  before_action :admin_teacher
  before_action :found_category, only: [:edit, :update, :show, :destroy, :accept_pending]
  
  def index
    if current_user.teacher?
      @categories = current_user.author.found_name(params[:name]).paginate(page: ( params[:page] if is_number? params[:page] ) )

    else
      @categories = Category.found_name(params[:name]).paginate(page: ( params[:page] if is_number? params[:page] ) )
    end
  end

  def edit
  end

  def new
    @category = Category.new 
  end
  
  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id
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

  def accept_pending
    if @category.update(status: 1)
      flash[:success] = t("inform.success")
      redirect_to admin_pending_category_path
    else
      flash[:success] = t("inform.unsuccess")
      redirect_to admin_pending_category_path
    end
  end

  def pending_category
    if current_user.teacher?
      @categories = current_user.author.pending.found_name(params[:name]).paginate(page: ( params[:page] if is_number? params[:page] ) )     
    else
      @categories = Category.pending.found_name(params[:name]).paginate(page: ( params[:page] if is_number? params[:page] ) )
    end
  end

  def destroy
    if @category.update(status: (@category.status = ( @category.status == "active") ? "unactive" :  "active"))
      flash[:success] = t("inform.success")
      redirect_to admin_categories_path
    else
      flash[:danger] = flash_errors(@category)
      redirect_to admin_categories_path
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
      params.require(:category).permit(:name, :decription, :image)
    end
end