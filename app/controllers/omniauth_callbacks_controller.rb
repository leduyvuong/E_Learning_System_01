class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    generic_callback("facebook")
  end

  def google_oauth2
    generic_callback( "google_oauth2" )
  end

  def twitter
    generic_callback("twitter")
  end

  def generic_callback _provider
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted? 
      log_in @user
      redirect_to home_path
    else
      flash[:danger] = flash_errors(@user)
      redirect_to root_path
    end
  end

  def failure
    flash[:danger] = t("inform.unsuccess")
    redirect_to root_path
  end
end 