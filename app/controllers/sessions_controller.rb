class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(login_id: params[:session][:login_id].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:notice] = "Loged in"
      log_in user
      redirect_back_or user
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
