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
      flash[:notice] = "既に参加済みです"
    else
      Attendee.create(user_id: current_user.id, event_id: @event.id)
      flash[:notice] = "参加が完了しました"
    end

    #redirect_to event_path(@event)
  end

  def index
    @events = Event.all
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
    @myevents = Event.joins(:attendees).where(attendees: { user_id: current_user.id })
  end

  private

  def event_params
    params.require(:event).permit(:event_name, :event_introduction, :date, :url)
  end
end
