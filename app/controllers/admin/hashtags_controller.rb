class Admin::HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find_by(id: params[:id])
    @posts = Post.joins(:hashtags).where(hashtags: { id: params[:id] }).order(created_at: :desc).page(params[:page]).per(8)
  end
end
