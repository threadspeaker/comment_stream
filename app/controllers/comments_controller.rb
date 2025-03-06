# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :require_login
  before_action :set_post
  before_action :set_comment, only: [:update, :destroy]
  before_action :authorize_user, only: [:update, :destroy]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.turbo_stream
        format.html { redirect_to @post, notice: "Comment was successfully added." }
      else
        format.html { redirect_to @post, alert: "Comment couldn't be created." }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.turbo_stream
        format.html { redirect_to @post, notice: "Comment was successfully updated." }
      else
        format.html { redirect_to @post, alert: "Comment couldn't be updated." }
      end
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @post, notice: "Comment was successfully deleted." }
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize_user
    unless @comment.user == current_user
      redirect_to @post, alert: "You are not authorized to perform this action."
    end
  end
end