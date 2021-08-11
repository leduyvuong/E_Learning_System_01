class LessonsController < ApplicationController
  def show 
    @lesson = Lesson.find_by(id: params[:id])
    @words = @lesson.content_lessons
  end
  def test
    @lesson = Lesson.find_by(id: params[:id])
    @questions = @lesson.questions
  end
  def result(ans_user,ques)
    @ans_user = ans_user
    @questions = ques
    return @ans_user && @questions
  end
  def result_test
    @lesson = Lesson.find_by(id: params[:id])
    @questions = @lesson.questions.all
    @dem = 0
    @ans_user = Hash.new
    @questions.each do |ans|
      if params["ques#{ans.id}"].nil?
        @ans_user[ans.id.to_s] = nil
      else
        @ans_user[ans.id.to_s] = params["ques#{ans.id}"]
      end
    end
    not_choose = t("errors.lesson.choose_answer")
    @questions.each do |q|
        @ans = q.answers.where("right_ans = 1").first  
        if params["ques#{q.id}"].nil?
          not_choose += "#{@questions.index(q) + 1 } "
        else
          if @ans.content == params["ques#{q.id}"]
            @dem +=1
          end
        end
      end 
    if not_choose == t("errors.lesson.choose_answer")
      flash[:success] = "#{@dem}/#{@questions.count}"
      return @ans_user && @questions
    else
      flash[:danger] = not_choose
      redirect_to request.referer
    end      
  end
end
