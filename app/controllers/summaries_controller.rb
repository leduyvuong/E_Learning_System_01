class SummariesController < ApplicationController
  before_action :current_user, only: [:create, :word_summary]
  def create
    @summary = @current_user.summaries.new(summary_params)
    @summary.status = true
    if @summary.save
      flash[:success] = t("errors.summary.created")
      redirect_to home_path
    else
      flash[:danger] = t("errors.content_empty")
      redirect_to home_path
    end 
  end
  def word_summary
    @words = ContentLesson.find_by(id: params[:id])
    if @words
      @content = @words.word + " | " + @words.mean
      @summary = @current_user.summaries.new(content: @content, status: true)
      if @summary.save
        flash[:success] = t("summary.success")
        redirect_to request.referer
      else
        flash[:danger] = flash_errors(@content)
        redirect_to request.referer
      end        
    else
      flash[:danger] = t("errors.word_not_found")
      redirect_to request.referer
    end
  end
  def unactive
    if @summary = Summary.find_by(id: params[:id]).update(status: false)
      flash[:success] = t("errors.success")
      redirect_to home_path
    else
      flash[:danger] = flash_errors(@summary)
      redirect_to home_path
    end
  end
  private
    def summary_params
      params.permit(:content)
    end
end
