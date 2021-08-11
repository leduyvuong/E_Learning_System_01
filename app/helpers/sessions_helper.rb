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
  def flash_errors(object)
    @flash = "Has #{object.errors.count} error: "
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