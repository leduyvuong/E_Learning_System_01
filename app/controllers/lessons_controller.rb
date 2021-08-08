class LessonsController < ApplicationController
  def show 
    @lesson = Lesson.find_by(id: params[:id])
    @words = @lesson.content_lessons
  end
end
