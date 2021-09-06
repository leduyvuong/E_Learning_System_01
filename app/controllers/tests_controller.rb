class TestsController < ApplicationController
  before_action :found_lesson, only: [:show, :result_test, :train, :result_user]
  def show
    @questions = @lesson.questions
  end

  def result_test
    session.delete(:ans_user)
    @questions = @lesson.questions
    count = 0   
    @ans_user = get_user_answer(@questions)
    session[:ans_user] = @ans_user
    not_choose = t("lesson.test.not_choose_ans")
    @questions.each do |q|
      ans = q.answers.right_answer.first  
      if params["ques#{q.id}"].nil?
        not_choose += "#{@questions.index(q) + 1 } "
      else
        if ans.content_lesson.word == params["ques#{q.id}"]
          count +=1
        end
      end
    end 
    if not_choose == t("lesson.test.not_choose_ans")     
      flash[:success] = "#{count}/#{@questions.count}"
      result_user count
      return @questions && @ans_user
    else   
      flash[:danger] = not_choose
      redirect_to request.referer
    end      
  end
  
  private
    def result_user content
      result = ResultLesson.new(user_id: current_user.id,
        content: content,
        lesson_id: @lesson.id)
      if !result.save
        flash[:danger] = flash_errors(result)
        redirect_to request.referer
      end
    end

    def get_user_answer(questions)
      ans_user = Hash.new
      questions.each do |ans|
        if params["ques#{ans.id}"].nil?
          ans_user[ans.id.to_s] = nil
        else
          ans_user[ans.id.to_s] = params["ques#{ans.id}"]
        end
      end
      ans_user
    end
    
    def found_lesson
      @lesson = Lesson.find_by(id: params[:id])
      return @lesson unless @lesson.nil?
      flash[:danger] = t("lesson.show.not_found")
      redirect_to home_path 
    end
end
