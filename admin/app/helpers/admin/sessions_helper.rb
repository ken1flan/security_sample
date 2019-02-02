module Admin
  module SessionsHelper
    def log_in(administrator)
      session[:administrator_id] = administrator.id
    end

    def log_out
      session.delete(:administrator_id)
      @current_administrator = nil
    end

    def current_administrator
      @current_administrator ||= Administrator.find_by(id: session[:administrator_id])
    end

    def logged_in?
      !current_administrator.nil?
    end

    def redirect_back_or(default)
      redirect_to(session[:forwarding_url] || default)
      session.delete(:forwarding_url)
    end

    def store_location
      session[:forwarding_url] = request.original_url if request.get?
    end
  end
end
