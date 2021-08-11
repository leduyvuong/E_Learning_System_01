class Admin::LessonsController < ApplicationController
  before_action :admin_user
  def index
    @lessons = Lesson.all.paginate(page: params[:page])
  end
end
