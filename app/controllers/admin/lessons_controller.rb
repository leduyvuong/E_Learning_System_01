class Admin::LessonsController < ApplicationController
  before_action :admin_teacher
  before_action :found_category, only: :new
  before_action only: [:edit, :update, :show, :destroy] do
    found_lesson params[:id]
  end
  before_action :list_category, only: [:edit, :update, :new]
  def index
    if current_user.teacher?
      @categories = current_user.author
      @lessons = Lesson.where("category_id in (#{@categories.ids.join(", ")})").filter_cate.paginate(page: ( params[:page] if is_number? params[:page] ))
    else
      @lessons = Lesson.all.filter_cate.paginate(page: ( params[:page] if is_number? params[:page] ))
    end
  end

  def edit  
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(params_lesson)
    if @lesson.save
      flash[:success] = t("inform.success")
      redirect_to admin_lessons_path
    else
      render :new 
    end
  end

  def show
  end

  def update
    if @lesson.update(params_lesson)
      flash[:success] = t("inform.success")
      render :edit
    else
      render :edit
    end
  end

  def destroy
    if @lesson.update(status: !@lesson.status)
      flash[:success] = t("inform.success")
      redirect_to admin_lessons_path
    else
      flash[:danger] = flash_errors(@lesson)
      redirect_to admin_lessons_path
    end
  end
  private

    def found_category
      @category = Category.find_by(id: params[:id_cate])
      return @category unless @category.nil?
      flash[:danger] = t("admin.categories.not_found")
      redirect_to admin_categories_path
    end

    def list_category
      if current_user.teacher?
        @categories = current_user.author.active.pluck(:name, :id)
      else
        @categories = Category.all.active.pluck(:name, :id)
      end
    end
    def params_lesson
      params.require(:lesson).permit(:name_lesson, :time, :category_id)
    end
end