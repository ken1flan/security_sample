class RedirectorsController < ApplicationController
  def show
    RedirectionLog.write(request)
    redirect_to params[:to]
  end
end
