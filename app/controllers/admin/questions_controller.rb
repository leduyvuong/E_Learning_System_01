class Admin::QuestionsController < ApplicationController
  before_action :admin_user
  before_action only: [:edit, :update, :destroy, :show] do
    found_question params[:id]
  end

  before_action only: :index do
    found_lesson params[:id_lesson]
  end

  def index
    @question = Question.new
    @questions = @lesson.questions.paginate(page: ( params[:page] if is_number? params[:page] ))
  end

  def edit
    @answer = Answer.new
    @words = ContentLesson.all.pluck(:word, :id)
    @answers = @question.answers.paginate(page: ( params[:page] if is_number? params[:page] ))
  end

  def create
    @lesson = Lesson.find_by(name_lesson: params_lesson["lesson_name"])
    if @lesson
      @question = Question.new(params_question)
      @question.lesson_id = @lesson.id
      if @question.save
        flash[:success] = t("inform.success")
        redirect_to request.referer
      else
        flash[:danger] = flash_errors(@question)
        redirect_to request.referer
      end
    else
      flash[:danger] = t("admin.lessons.not_found")
      redirect_to request.referer
    end
  end

  def update
    if @question.update(params_question)
      flash[:success] = t("inform.success")
      redirect_to request.referer
    else
      flash[:danger] = flash_errors(@question)
      redirect_to request.referer
    end
  end

  def destroy
    if @question.destroy
      flash[:success] = t("inform.success")
      redirect_to request.referer
    else
      flash[:danger] = flash_errors(@question)
      redirect_to request.referer
    end
  end
  
  private
    def params_lesson
      params.require(:question).permit(:lesson_name)
    end
    
    def params_question
      params.require(:question).permit(:content)
    end
end