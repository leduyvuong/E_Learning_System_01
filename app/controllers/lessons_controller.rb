class LessonsController < ApplicationController
  before_action :found_lesson, only: [:show, :train, :down_lesson]
  before_action :check_teacher, only: :down_lesson
  def show
    session.delete(:ans_user)
    @words = @lesson.content_lessons
  end
  def down_lesson
    @words = @lesson.content_lessons
    respond_to do |format|
      format.html
      format.pdf do
        render template: "lessons/down_lesson.html.erb",
          pdf: "Lesson_#{@lesson.name_lesson}"
      end
    end
  end
  def user_lesson
    render :user_lesson
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
    def check_teacher
      if !teacher_admin
        redirect_to home_path
      end
    end
end