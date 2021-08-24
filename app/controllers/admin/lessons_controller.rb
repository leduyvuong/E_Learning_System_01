class Admin::LessonsController < ApplicationController
  before_action :admin_user
  before_action :found_lesson, only: [:edit, :update, :show, :destroy]
  def index
    @lessons = Lesson.all.paginate(page: params[:page])
  end
  def edit 
  end
  def new 
    @lesson = Lesson.new
  end
  def create
    @category = Category.find_by(name: params[:lesson][:cate])
    @lesson = @category.lessons.new(params_lesson_new)
    @lesson.status = true
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
    @category = Category.find_by(name: params[:lesson][:category_id])
    @lesson.category_id = @category.id
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
    def params_lesson
      params.require(:lesson).permit(:name_lesson, :time)
    end
    def params_lesson_new
      params.require(:lesson).permit(:name_lesson, :time)
    end
    def found_lesson
      @lesson = Lesson.find_by(id: params[:id])
        return @lesson unless @lesson.nil? 
        flash[:danger] = t("admin.lesson.not_found")
        redirect_to admin_lessons_path
    end 
end