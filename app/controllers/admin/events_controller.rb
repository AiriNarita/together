class Admin::EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    @attendee = Attendee.find_by(user_id: current_user.id, event_id: @event.id)
  end

  def index
    @events = Event.visible.page(params[:page]).per(8)
  end
end
