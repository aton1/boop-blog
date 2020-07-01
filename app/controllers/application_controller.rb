class ApplicationController < ActionController::Base
  # to let the helper method also be used in ApplicationHelper for our views
  helper_method :current_user, :logged_in?

  # return details of current user that's logged in
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # check if user is logged in by making current_user into a boolean
  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = "You need to be logged in."
      redirect_to login_path
    end
  end
end
