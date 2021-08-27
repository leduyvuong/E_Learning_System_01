class LessonsController < ApplicationController
  before_action :found_lesson, only: [:show, :train]
  def show
    session.delete(:ans_user)
    @words = @lesson.content_lessons
  end

  def train
    @words = @lesson.content_lessons
  end
  private
    def found_lesson
      @lesson = Lesson.find_by(id: params[:id])
      return @lesson unless @lesson.nil?
      flash[:danger] = t("lesson.show.not_found")
      redirect_to home_path
    end
end