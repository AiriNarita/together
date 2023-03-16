class Admin::EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    @attendee = Attendee.find_by(user_id: current_user.id, event_id: @event.id)
  end

  def index
    @events = Event.visible.page(params[:page]).per(8)

    case params[:sort]
    when "favorites"
      @events = @events.order(attendee_count: :desc)
    when "latest"
      @events = @events.order(created_at: :desc)
    end
  end
end
