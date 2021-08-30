class Admin::AnswersController < ApplicationController
  before_action :admin_user
  before_action :found_answer, only: [:edit, :update, :destroy, :show]
  before_action only: :create do
    found_question params[:id_question]
  end

  def update
    if @answer.update(params_answer)
      flash[:success] = t("inform.success")
      redirect_to request.referer
    else
      flash[:danger] = flash_errors(@answer)
      redirect_to request.referer
    end
  end

  def create
    @answer = Answer.new(params_answer)
    @answer.question_id = @question.id
    if @answer.save
      flash[:success] = t("inform.success")
      redirect_to request.referer
    else
      flash[:danger] = flash_errors(@answer)
      redirect_to request.referer
    end
  end

  def destroy
    if @answer.destroy
      flash[:success] = t("inform.success")
      redirect_to request.referer
    else
      flash[:danger] = flash_errors(@answer)
        redirect_to request.referer
    end
  end

  private
    def found_answer
      @answer = Answer.find_by(id: params[:id])
      return @answer unless @answer.nil? 
      flash[:danger] = t("admin.answers.not_found")
      redirect_to request.referer
    end
    
    def params_answer
      params.permit(:content_lesson_id, :right_ans)
    end
end