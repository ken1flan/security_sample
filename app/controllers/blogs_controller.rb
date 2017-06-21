class BlogsController < ApplicationController
  def index
    @blogs = Blog.published.order("updated_at DESC")
  end

  def show
    @blog = Blog.find(params[:id])
  end
end
