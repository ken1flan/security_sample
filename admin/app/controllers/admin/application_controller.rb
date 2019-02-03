module Admin
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    include Admin::SessionsHelper

    before_action :required_login

    private

    def required_login
      if logged_in?
        # DO NOTHING
      else
        store_location
        redirect_to new_session_path
      end
    end
  end
end
