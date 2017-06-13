class TopController < ApplicationController
  def show
    redirect_to blogs_path if logged_in?
  end
end
