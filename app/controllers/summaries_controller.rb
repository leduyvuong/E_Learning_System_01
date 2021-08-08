class SummariesController < ApplicationController
  before_action :current_user, only: [:create, :word_summary]
  def create
    @summary = @current_user.summaries.new(summary_params)
    @summary.status = true
    if @summary.save
      flash[:success] = "Summary created!"
      redirect_to home_path
    else
      flash[:danger] = "Content can't be empty "
      redirect_to home_path
    end 
  end
  def word_summary
    @words = ContentLesson.find_by(id: params[:id])
    if @words
      @content = @words.word + " | " + @words.mean
      @summary = @current_user.summaries.new(content: @content, status: true)
      if @summary.save
        flash[:success] = "Add summary successful!"
        redirect_to request.referer
      else
        flash[:danger] = "Something wrong!" + @summary.content
        redirect_to request.referer
      end        
    else
      flash[:danger] = "Something wrong!" + params[:id]
      redirect_to request.referer
    end
  end
  def unactive
    if Summary.find_by(id: params[:id]).update(status: false)
      flash[:success] = "Successful"
      redirect_to home_path
    else
      flash[:danger] = "Not successful"
      redirect_to home_path
    end
  end
  private
    def summary_params
      params.permit(:content)
    end
end
