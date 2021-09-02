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
  def parse_data_user data
    user_data = Hash.new()
    if I18n.locale == :vi
      user_data["Người quản trị"] = data["admin"]
      user_data["Giáo viên"] = data["teacher"]
      user_data["Học viên"] = data["student"]
    else
      user_data["Admin"] = data["admin"]
      user_data["Teacher"] = data["teacher"]
      user_data["Student"] = data["student"]
    end
    user_data
  end

  def parse_line_user data
    user_data = Hash.new()
    if I18n.locale == :vi
      data.keys.each do |n|
        user_data[I18n.l(Date.parse(n.to_s), format: '%d %b %y')] = data[n]
      end
      return user_data
    else
      return data
    end
  end

  def year_list data
    data.map(&:year)
  end
  def float_number number
    "%.3f" % number
  end

  def admin_user
    redirect_to(home_url) unless current_user.admin?
  end
  
  def admin_teacher
    if !teacher_admin
      redirect_to home_path
    end
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