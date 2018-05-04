class BlogsController < ApplicationController
  def index
    @blogs = Blog.includes(:user).published.order("updated_at DESC")

    @search_text = params[:search_text]
    @search_start_at = params[:search_start_at]
    @search_end_at = params[:search_end_at]

    if @search_text.present?
      @blogs = @blogs.where("title LIKE \"%#{@search_text}%\" OR body LIKE \"%#{@search_text}%\"")
    end

    if @search_start_at.present?
      @blogs = @blogs.where("created_at >= '#{@search_start_at}'")
    end

    if @search_end_at.present?
      @blogs = @blogs.where("created_at <= '#{@search_end_at}'")
    end
  end

  def show
    @blog = Blog.published.find(params[:id])
  end
end
