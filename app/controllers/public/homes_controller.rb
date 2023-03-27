class Public::HomesController < ApplicationController
  def top
    @posts = Post.includes(:hashtags)
                 .left_joins(:favorites)
                 .select("posts.*, COUNT(favorites.id) AS favorites_count")
                 .group("posts.id")
                 .order("favorites_count DESC")
                 .limit(4)

    @events = Event.left_joins(:attendees)
                   .select("events.*, COUNT(attendees.id) AS attendees_count")
                   .group("events.id")
                   .where("date >= ?", Time.now)
                   .order("attendees_count DESC")
                   .limit(4)
  end
end
