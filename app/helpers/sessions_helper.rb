module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  def change_ans(questions)
    ans = questions.answers.to_a
    if ans.length > 3
      a = [0, 1, 2, 3]
      ran_1 = a.sample
      a.delete(ran_1)
      ran_2 = a.sample
      a.delete(ran_2)
      ans[ran_1], ans[ran_2] = ans[ran_2], ans[ran_1]
      ans[a[0]], ans[a[1]] = ans[a[1]], ans[a[0]]
    end
    ans
  end
  
  def flash_errors(object)
    if object.errors.any?
      t("inform.has_err" , err: object.errors.count) + object.errors.full_messages.join(", ")
    end
  end

  def admin_user
    redirect_to(home_url) unless current_user.admin?
  end
  
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end
end