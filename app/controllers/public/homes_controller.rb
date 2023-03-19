class Public::HomesController < ApplicationController
  def top
    @posts = Post.includes(:hashtags).order(likes_count: :desc).limit(4)
    @events = Event.order(attendees_count: :desc).limit(4)
  end
end
