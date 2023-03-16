class Public::EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.creator = current_user
    if @event.save
      redirect_to event_path(@event)
    else
      render "new"
    end
  end

  def show
    @event = Event.find(params[:id])
    @attendee = Attendee.find_by(user_id: current_user.id, event_id: @event.id)

    if @attendee
      flash.now[:notice] = "参加を決定しました。イベントのURL: #{@event.url}"
    else
      Attendee.create(user_id: current_user.id, event_id: @event.id)
    end
  end

  def index
    @events = Event.visible.page(params[:page]).per(8)
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.creator = current_user
    if @event.update(event_params)
      redirect_to event_path(@event)
    else
      render "edit"
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      redirect_to events_path
    end
  end

  def myevent
    if params[:event_type] == "created_events"
      @myevents = current_user.events.where(creator_id: current_user.id).page(params[:page]).per(8)
    elsif params[:event_type] == "upcoming_events"
      @myevents = current_user.events.where(creator_id: current_user.id).where("date >= ?", Time.now).page(params[:page]).per(8)
    elsif params[:event_type] == "past_events"
      @myevents = current_user.events.where("date < ?", Time.now).page(params[:page]).per(8)
    elsif params[:event_type] == "attended_events"
      @myevents = Event.joins(:attendees).where(attendees: { user_id: current_user.id }).where.not(creator_id: current_user.id).page(params[:page]).per(8)
    elsif params[:event_type] == "past_attended_events"
      @myevents = Event.joins(:attendees).where(attendees: { user_id: current_user.id }).where("date < ?", Time.now).where.not(creator_id: current_user.id).page(params[:page]).per(8)
    else
      @myevents = Event.joins(:attendees).where(attendees: { user_id: current_user.id }).page(params[:page]).per(8)
    end
  end

  private

  def event_params
    params.require(:event).permit(:event_name, :event_introduction, :date, :url)
  end
end
