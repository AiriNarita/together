class Admin::PostsController < ApplicationController
  def index
    @posts = Post.visible.page(params[:page]).per(8)

    case params[:sort]
    when "favorites"
      # @posts = @posts.order(attendee_count: :desc)
      @posts = @posts.includes(:hashtags)
        .left_joins(:favorites)
        .select("posts.*, COUNT(favorites.id) AS favorites_count")
        .group("posts.id")
        .order("favorites_count DESC")
        .visible.order(favorites_count: :desc).page(params[:page]).per(8)
    when "latest"
      @posts = @posts.order(created_at: :desc).page(params[:page]).per(8)
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_hashtags = @post.hashtags
  end
end
