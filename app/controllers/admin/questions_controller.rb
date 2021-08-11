class Admin::QuestionsController < ApplicationController
  before_action :admin_user
  before_action :found_question, only: [:edit, :update, :destroy, :show]
  def index
    @lesson = Lesson.find_by(id: params[:id_lesson])
    @questions = @lesson.questions
  end
  def edit 
    
  end
  def update
    if @question.update(params_question)
      flash[:success] = "Successfull"
      redirect_to request.referer
    else
      flash[:danger] = "Question " +flash_errors(@question)
      redirect_to request.referer
    end
  end
  private
    def found_question
      @question = Question.find_by(id: params[:id])
        return @question unless @question.nil? 
        flash[:danger] = "No found question"
        redirect_to request.referer
    end
    def params_question
      params.require(:question).permit(:content)
    end
end
