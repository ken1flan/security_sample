class RedirectorsController < ApplicationController
  def show
    # do something
    redirect_to params[:to]
  end
end
