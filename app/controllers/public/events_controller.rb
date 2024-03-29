class Public::EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :author_user, only: [:edit]

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
    @event = Event.includes(attendees: :user).find(params[:id])
    @attendees = @event.attendees.uniq(&:user_id)
    @is_past_event = @event.date < Time.now
    if user_signed_in?
      @attendee = Attendee.find_by(user_id: current_user.id, event_id: @event.id)

      if @attendee
        flash.now[:notice] = "Clicked backup URL: #{@event.url}"
      else
        # Attendee.create(user_id: current_user.id, event_id: @event.id)
      end
    end
  end

  def index
    @events = Event.visible.page(params[:page]).per(9)
    params[:sort] = params[:sort].blank? ? "ALL" : params[:sort]
    case params[:sort]
    # query paramはControllerやViewとかでたくさん使われるから、Enum化することがベスト、それともHuman Missが出ないように全ての文字を大文字にするか小文字に統一することがベスト
    when "ALL"
      @events = Event.visible.page(params[:page]).per(9)
    when "ONLINE"
      @events = Event.visible.online.page(params[:page]).per(9)
    when "OFFLINE"
      @events = Event.visible.offline.page(params[:page]).per(9)
    end
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
    #countをviewではなくここで書いたのは、pagenationなどに影響されないため
    @createdCount = Event.joins(:creator).where(creator: { id: current_user.id }).count
    @upcoming = Event.joins(:creator).where(creator: { id: current_user.id }).where("date >= ?", Time.now).count
    @past_events = Event.joins(:creator).where(creator: { id: current_user.id }).where("date < ?", Time.now).count
    @attendedCount = Event.joins(:attendees).where(attendees: { user_id: current_user.id }).where("date >= ?", Time.now).where.not(creator_id: current_user.id).distinct.count
    @pastAttendedCount = Event.joins(:attendees).where(attendees: { user_id: current_user.id }).where("date < ?", Time.now).where.not(creator_id: current_user.id).distinct.count

    if params[:event_type] == "created_events"
      @myevents = Event.joins(:creator).where(creator: { id: current_user.id }).page(params[:page]).per(8)
    elsif params[:event_type] == "upcoming_events"
      @myevents = Event.joins(:creator).where(creator: { id: current_user.id }).where("date >= ?", Time.now).page(params[:page]).per(8)
    elsif params[:event_type] == "past_events"
      @myevents = Event.joins(:creator).where(creator: { id: current_user.id }).where("date < ?", Time.now).page(params[:page]).per(8)
    elsif params[:event_type] == "attended_events"
      @myevents = Event.joins(:attendees).where(attendees: { user_id: current_user.id }).where("date >= ?", Time.now).where.not(creator_id: current_user.id).distinct.page(params[:page]).per(8)
    elsif params[:event_type] == "past_attended_events"
      @myevents = Event.joins(:attendees).where(attendees: { user_id: current_user.id }).where("date < ?", Time.now).where.not(creator_id: current_user.id).distinct.page(params[:page]).per(8)
    else
      @myevents = Event.joins(:attendees).where(attendees: { user_id: current_user.id }).page(params[:page]).per(8)
    end
  end

  private

  def event_params
    params.require(:event).permit(:event_name, :event_introduction, :date, :url, :event_image, :event_type, :address, :latitude, :longitude)
  end

  #user　編集制限validation (投稿のidに関連するuseridとログイン中のidが同じな時以外で)
  def author_user
    unless Event.find(params[:id]).creator.id.to_i == current_user.id
      redirect_to events_path
    end
  end
end
