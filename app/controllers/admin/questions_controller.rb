class Admin::QuestionsController < ApplicationController
  before_action :admin_user
  before_action :found_question, only: [:edit, :update, :destroy, :show]
  def index
    @question = Question.new
    @lesson = Lesson.find_by(id: params[:id_lesson])
    @questions = @lesson.questions.paginate(page: params[:page])
  end

  def edit
    @answer = Answer.new
    @answers = @question.answers.paginate(page: params[:page])
  end

  def create
    @lesson = Lesson.find_by(name_lesson: params[:question][:lesson_id])
    @question = Question.new(params_question)
    @question.lesson_id = @lesson.id
    if @question.save
      flash[:success] = t("inform.success")
      redirect_to request.referer
    else
      flash[:danger] = flash_errors(@question)
      redirect_to request.referer
    end
  end

  def update
    if @question.update(params_question)
      flash[:success] = t("inform.success")
      redirect_to request.referer
    else
      flash[:danger] = "Question " +flash_errors(@question)
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
    def found_question
      @question = Question.find_by(id: params[:id])
        return @question unless @question.nil? 
        flash[:danger] = t("admin.questions.not_found")
        redirect_to request.referer
    end

    def params_question
      params.require(:question).permit(:content)
    end
end
