class Users::BlogsController < ApplicationController
  before_action :set_user
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  # GET /blogs
  # GET /blogs.json
  def index
    if @user == current_user
      @blogs = @user.blogs.order("updated_at DESC")
    else
      @blogs = @user.blogs.published.order("updated_at DESC")
    end
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    @blog = Blog.new(user: current_user)
  end

  # GET /blogs/1/edit
  def edit
    unless @blog.user == current_user
      flash[:warn] = "This blog is not yours."
      redirect_to blogs_path
    end
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)
    @blog.user = current_user

    respond_to do |format|
      if @blog.save
        format.html { redirect_to user_blog_path(@blog.user, @blog), notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    unless @blog.user == current_user
      flash[:warn] = "This blog is not yours."
      redirect_to blogs_path
      return
    end

    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to user_blog_path(@blog.user, @blog), notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    unless @blog.user == current_user
      flash[:warn] = "This blog is not yours."
      redirect_to user_blogs_path(current_user)
      return
    end

    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:user_id])
    end

    def set_blog
      @blog = @user.blogs.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title, :body, :status)
    end
end
