class Admin::PostCommentsController < ApplicationController
  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    redirect_back(fallback_location: root_path)
  end
end
