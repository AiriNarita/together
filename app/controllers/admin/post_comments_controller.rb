class Admin::PostCommentsController < ApplicationController
  def destroy
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    @post_comments = PostComment.where(post_id: params[:post_id]).order(created_at: :desc)
    redirect_back(fallback_location: root_path)
  end
end
