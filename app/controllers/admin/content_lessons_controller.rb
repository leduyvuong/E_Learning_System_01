class Admin::ContentLessonsController < ApplicationController
  before_action :admin_user
  before_action :found_content_lesson, only: [:edit, :update, :show, :destroy]
  def index
    @content_lesson = ContentLesson.new
    @lesson = Lesson.find_by(id: params[:id_lesson])
    return @content_lessons = @lesson.content_lessons.paginate(page: params[:page]) unless @lesson.nil?
    flash[:danger] = t("admin.lesson.not_found")
    redirect_to admin_lessons_path
  end
  def new
  end
  def create
    @lesson = Lesson.find_by(name_lesson: params[:content_lesson][:lesson_id])
    if @lesson
      @content_lesson = @lesson.content_lessons.new(params_word_new)
      if @content_lesson.save
        flash[:success] = t("inform.success")
        redirect_to request.referer 
      else
        flash[:danger] = flash_errors(@content_lesson)
        redirect_to request.referer
      end
    else
      flash[:danger] = t("admin.lesson.not_found")
        redirect_to request.referer
    end
  end 
  def update
    if @content.update(params_word)
      flash[:success] = t("inform.success")
      redirect_to request.referer 
    else
      flash[:danger] = flash_errors(@content)
      redirect_to request.referer 
    end
  end
  def destroy
    if @content.destroy
      flash[:success] = t("inform.success")
      redirect_to request.referer
    else
      flash[:danger] = flash_errors(@content)
      redirect_to request.referer
    end
  end
  private
    def found_content_lesson
      @content = ContentLesson.find_by(id: params[:id])
      return @content unless @content.nil?
      flash[:danger] = t("admin.content_lessons.not_found")
      redirect_to admin_lessons_path
    end 
    def params_word
      params.permit(:word, :pronounce, :mean)
    end
    def params_word_new
      params.require(:content_lesson).permit(:word, :pronounce, :mean)
    end
end