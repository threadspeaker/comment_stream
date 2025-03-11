class PostsController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
  
    if @post.save
      # For Turbo Stream requests, send a redirect header
      if turbo_stream_request?
        request.format = :html
        redirect_to @post, notice: "Post was successfully created."
        return
      end
      
      # For HTML requests
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        # For Turbo Stream requests, send a redirect header
        if turbo_stream_request?
          request.format = :html
          redirect_to @post, notice: "Post was successfully updated."
          return
        end
        
        # For HTML requests
        redirect_to @post, notice: "Post was successfully updated."
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    
    if turbo_stream_request?
      request.format = :html
      redirect_to posts_path, notice: "Post was successfully deleted."
      return
    end
    
    redirect_to posts_path, notice: "Post was successfully deleted."
  end

  private

  def turbo_stream_request?
    request.format.symbol == :turbo_stream
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def authorize_user
    unless @post.user == current_user
      redirect_to posts_path, alert: "You are not authorized to perform this action."
    end
  end
end
