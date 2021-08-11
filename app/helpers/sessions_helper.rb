module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  def logged_in?
    !current_user.nil?
  end
  def admin_user
    redirect_to(home_url) unless current_user.admin?
  end
  def change_ans(questions)
    @ans = questions.answers.to_a
    @ans1 = questions.answers
    a = [0, 1, 2, 3]
    ran_1 = a.sample
    a.delete(ran_1)
    ran_2 = a.sample
    a.delete(ran_2)
    @temp = @ans[ran_1] 
    @ans[ran_1] = @ans[ran_2] 
    @ans[ran_2] = @temp
    @temp = @ans[a[0]]
    @ans[a[0]] = @ans[a[1]]
    @ans[a[1]] = @temp
    return @ans
  end
  def flash_errors(object)
    @flash = t("errors.has_err" , err: object.errors.count)
    if object.errors.any?
      object.errors.full_messages.each do |n|
        if object.errors.full_messages.last == n
          @flash += n + "."
        else
          @flash += n + ", "
        end 
      end
    end
    return @flash
  end
end