class Admin::LessonsController < ApplicationController
  before_action :admin_user
  before_action only: [:edit, :update, :show, :destroy] do
    found_lesson params[:id]
  end
  def index
    @lessons = Lesson.all.filter_cate.paginate(page: ( params[:page] if is_number? params[:page] ))
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
    def params_lesson
      params.require(:lesson).permit(:name_lesson, :time, :category_id)
    end
end