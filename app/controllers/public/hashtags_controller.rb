class Public::HashtagsController < ApplicationController
  def show
    @posts = Post.joins(:hashtags).where(hashtags: { hashtag_name: params[:hashtag_name] }).order(created_at: :desc)
  end
end
