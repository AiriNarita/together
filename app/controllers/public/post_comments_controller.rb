class Public::PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.post_comments.new(post_comment_params)
    @comment.post_id = params[:post_id]
    @comment.save
    @post_comments = PostComment.where(post_id: params[:post_id]).order(created_at: :desc)
    #redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    @post_comments = PostComment.where(post_id: params[:post_id]).order(created_at: :desc)
    #redirect_back(fallback_location: root_path)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
