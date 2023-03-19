class Public::HashtagsController < ApplicationController
  def show
    #@hashtag = Hashtag.find_by(hashtag_name: params[:hashtag_name])
    #@posts = Post.joins(:hashtags).where(hashtags: { hashtag_name: params[:hashtag_name] }).order(created_at: :desc)

    @hashtag = Hashtag.find_by(id: params[:id])

    if @hashtag.present?
      @posts = Post.joins(:hashtags).where(hashtags: { id: params[:id] }).order(created_at: :desc)
    else
      @posts = []
    end
  end
end
