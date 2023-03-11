class Public::AttendeesController < ApplicationController
  def create
    params
    @attendee = Attendee.new(attendee_params)
    if @attendee.save
      @event = Event.find(params[:event_id])
      redirect_to event_path(@event)
      flash[:notice] = "参加が完了しました"
    end
  end

  def destroy
    @attendee = Attendee.find(params[:id])
    if @attendee.destroy
      redirect_to events_path
    end
  end

  def attendee_params
    # event_idとuser_idが必要。
    params.permit(:event_id).merge(user_id: current_user.id)
  end
end
