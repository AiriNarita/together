class Admin::PostsController < ApplicationController
  def index
    @posts = Post.visible

    case params[:sort]
    when "attendee"
      # @posts = @posts.order(attendee_count: :desc)
      @posts = @posts
    when "latest"
      @posts = @posts.order(created_at: :desc)
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_hashtags = @post.hashtags
  end
end
