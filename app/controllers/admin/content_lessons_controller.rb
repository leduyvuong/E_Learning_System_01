class Admin::ContentLessonsController < ApplicationController
  before_action :admin_user
  before_action :found_content_lesson, only: [:edit, :update, :show, :destroy]
  before_action only: :index do
    found_lesson  params[:id_lesson]
  end

  def index
    @content_lesson = ContentLesson.new
    @lessons = Lesson.all.pluck(:name_lesson, :id)
    @content_lessons = @lesson.content_lessons.paginate(page: params[:page])
  end

  def new
  end

  def create
    @content_lesson = ContentLesson.new(params_word_new)
    if @content_lesson.save
      flash[:success] = t("inform.success")
      redirect_to request.referer 
    else
      flash[:danger] = flash_errors(@content_lesson)
      redirect_to request.referer
    end
  end 

  def update
    if @content.update(params_word_update)
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

    def params_word_update
      params.permit(:word, :pronounce, :mean, :lesson_id, :audio_word, :image)
    end

    def params_word_new
      params.require(:content_lesson).permit(:word, :pronounce, :mean, :lesson_id, :audio_word, :image)
    end
end