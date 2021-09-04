class TestsController < ApplicationController
  before_action :found_lesson, only: [:show, :result_test, :train, :result_user]
  def show
    session.delete(:ans_user)
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
      if ans.content_lesson.word == params["ques#{q.id}"]
        count +=1
      end
    end     
    mark_user @lesson, count
    return @questions && @ans_user      
  end
  
  private

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

    def mark_user lesson, count
      if count == lesson.questions.count
        mark = 10
      else
        mark = count * (10 / lesson.questions.count.to_f)
      end
      if mark >= 8
        if result = ResultLesson.found_user(current_user.id, lesson.id).first
          if mark > result.content.to_i
            unless result.update(content: mark)
              flash[:danger] = "Lỗi hệ thống"
              redirect_to root_path
            end
          end  
        else
          result = ResultLesson.new(content: mark, user_id: current_user.id, lesson_id: lesson.id)
          if result.save
            unless Activity.create!(owner: result, user_id: result.user_id)
              flash[:danger] = "Lỗi hệ thống"
              redirect_to root_path
            end
          else
            flash[:danger] = "Lỗi hệ thống"
            redirect_to root_path
          end
        end
        flash[:success] = "#{mark}/10"
      else
        flash[:danger] = "Failed #{mark}/10"
        redirect_to user_lesson_path(id: lesson.category_id)
      end
    end  
    def found_lesson
      @lesson = Lesson.find_by(id: params[:id])
      return @lesson unless @lesson.nil?
      flash[:danger] = t("lesson.show.not_found")
      redirect_to home_path 
    end
end
