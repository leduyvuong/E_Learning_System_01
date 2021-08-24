class Admin::AnswersController < ApplicationController
  before_action :admin_user
  before_action :found_answer, only: [:edit, :update, :destroy, :show]
  def update
    if @answer.update(params_answer)
      flash[:success] = t("inform.success")
      redirect_to request.referer
    else
      flash[:danger] = "Answer " +flash_errors(@answer)
      redirect_to request.referer
    end
  end
  def create
    if @question = Question.find_by(id: params[:id_question])
      @answer = Answer.new(params_answer)
      @answer.question_id = @question.id
      if @answer.save
        flash[:success] = t("inform.success")
        redirect_to request.referer
      else
        flash[:danger] = "Answer " +flash_errors(@answer)
        redirect_to request.referer
      end
    else
      flash[:danger] = "not found question"
        redirect_to admin_questions_path
    end
  end
  def destroy
    if @answer.destroy
      flash[:success] = t("inform.success")
      redirect_to request.referer
    else
      flash[:danger] = "Answer a" +flash_errors(@answer)
        redirect_to request.referer
    end
  end
  private
    def found_answer
      @answer = Answer.find_by(id: params[:id])
      return @answer unless @answer.nil? 
      flash[:danger] = "No found answer"
      redirect_to request.referer
    end
    def params_answer
      params.permit(:content, :right_ans)
    end
end
