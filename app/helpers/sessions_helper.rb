module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  def flash_errors(object)
    if object.errors.any?
      t("inform.has_err" , err: object.errors.count) + object.errors.full_messages.join(", ")
    end
  end

  def is_number? string
    true if Integer(string) rescue false
  end

  def swap_string string
    array = string.split("")
    
    4.times do
      location_array = (0...array.count).to_a
      ran1 = location_array.sample
      location_array.delete(ran1)
      ran2 = location_array.sample
      location_array.delete(ran2)
      array[ran1], array[ran2] = array[ran2], array[ran1] 
    end
    array
  end
  def admin_user
    redirect_to(home_url) unless current_user.admin?
  end
  
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def teacher_admin
    current_user.teacher? || current_user.admin?
  end

  def logged_in?
    !current_user.nil?
  end
end