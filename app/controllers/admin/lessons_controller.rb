class Admin::LessonsController < ApplicationController
  before_action :admin_user
  before_action :found_lesson, only: [:edit, :update, :show, :destroy]
  def index
    @lessons = Lesson.search(params[:name]).paginate(page: params[:page])
    if @lessons.count == 0
      flash[:danger] = "There is no lesson with the same name #{params[:name]}"
      @lessons = Lesson.all.paginate(page: params[:page])
    end
  end
  def new 
    @lesson = Lesson.new
    @categories = Category.all.pluck(:name)
  end
  def create
    @category = Category.find_by(name: params[:lesson][:cate])
    @lesson = @category.lessons.new(params_lesson_new)
    @lesson.status = true
    if @lesson.save
      flash[:success] = "Created success"
      redirect_to admin_lessons_path
    else
      @categories = Category.all.pluck(:name)
      render :new 
    end
  end
  def show
  end
  def update
    @lesson.status = true unless @lesson.status == true
    if @lesson.update(params_lesson)
      flash[:success] = "Update success"
      redirect_to admin_lessons_path
    else     
      flash[:danger] = flash_errors(@lesson)
      redirect_to admin_lessons_path
    end
  end
  def destroy
    if @lesson.update(status: false)
      flash[:success] = "Unactive success"
      redirect_to admin_lessons_path
    else
      flash[:success] = "Unactive unsuccess"
      redirect_to admin_lessons_path
    end
  end
  private
    def params_lesson
      params.permit(:name_lesson, :time)
    end
    def params_lesson_new
      params.require(:lesson).permit(:name_lesson, :time)
    end
    def found_lesson
      @lesson = Lesson.find_by(id: params[:id])
        return @lesson unless @lesson.nil? 
        flash[:danger] = "No found lesson"
        redirect_to admin_lessons_path
    end 
end
