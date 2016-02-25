class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]

  def create
    if @post = Post.find(params[:post_id])
      @post = Post.find(params[:post_id])
      comment = @post.comments.new(comment_params)
    else
      @topic = Topic.find(params[:topic_id])
      comment = @topic.comments.new(comment_params)
    end
      comment.user = current_user

    if comment.save
      flash[:notice] = "Comment saved successfully."
      if @post
        redirect_to [@post.topic, @post]
      else
        redirect_to [@topic]
      end
    else
      flash[:alert] = "Comment failed to save."
      redirect_to [@post.topic, @post]
    end
  end

  def destroy
    if @post = Post.find(params[:post_id])
      @post = Post.find(params[:post_id])
      comment = @post.comments.find(params[:id])
    else
      @topic = Topic.find(params[:topic_id])
      comment = @topic.comments.find(params[:id])
    end

    if comment.destroy
      flash[:notice] = "Comment was deleted."
      if @post
        redirect_to [@post.topic, @post]
      else
        redirect_to [@topic]
      end
    else
      flash[:alert] = "Comment couldn't be deleted. Try agin."
      redirect_to [@post.topic, @post]
      redirect_to [@topic]
    end
  end

    private

    def comment_params
      params.require(:comment).permit(:body)
    end

    def authorize_user
      comment = Comment.find(params[:id])
      unless current_user == comment.user || current_user.admin?
        flash[:alert] = "You do not have permission to delete a comment."
        redirect_to [comment.post.topic, comment.post]
      end
    end
end
