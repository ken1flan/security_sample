require_dependency "admin/application_controller"

module Admin
  class SessionsController < ApplicationController
    def new
    end

    def create
      administrator = ::Administrator.find_by(login_id: params[:session][:login_id].downcase)
      if administrator && administrator.authenticate(params[:session][:password])
        flash[:notice] = "Loged in"
        log_in administrator
        redirect_back_or root_path
      else
        flash[:warn] = "Log in failed"
        render :new
      end
    end

    def destroy
      log_out

      flash[:notice] = "Loged out"
      redirect_to new_session_path
    end
  end
end
