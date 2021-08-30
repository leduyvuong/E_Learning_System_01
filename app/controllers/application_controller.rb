class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_locale

  private
  def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
      {locale: I18n.locale}
  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  def found_lesson id
    @lesson = Lesson.find_by(id: id)
    return @lesson unless @lesson.nil? 
    flash[:danger] = t("admin.lesson.not_found")
    redirect_to admin_lessons_path
  end

  def found_question id
    @question = Question.find_by(id: id)
    return @question unless @question.nil? 
    flash[:danger] = t("admin.questions.not_found")
    redirect_to request.referer
  end 
end
