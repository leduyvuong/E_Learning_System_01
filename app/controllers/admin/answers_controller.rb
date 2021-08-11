class Admin::AnswersController < ApplicationController
  before_action :admin_user
  before_action :found_answer, only: [:edit, :update, :destroy, :show]
  def update
    if @answer.update(params_answer)
      flash[:success] = "Successfull"
      redirect_to request.referer
    else
      flash[:danger] = "Answer " +flash_errors(@answer)
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
      params.permit(:content)
    end
end
