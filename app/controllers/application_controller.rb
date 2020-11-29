class ApplicationController < ActionController::Base
  add_flash_types :success, :warning, :danger, :info
  helper_method :current_user
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end
  def authenticate
    unless current_user
      redirect_to root_path
    end
  end
end
