class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :log_in, :log_out, :current_user, :logged_in?

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end
end
