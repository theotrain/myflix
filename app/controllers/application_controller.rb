class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?


  def logged_in?
    !!current_user
  end

  def current_user
    # if theres an authenticated user, return user object else nil
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    if !logged_in?
      flash[:error] = 'Must be logged in to do that.'
      redirect_to root_path
    end
  end

end
