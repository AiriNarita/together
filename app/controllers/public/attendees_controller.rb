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
    # id => user_id
    # event_id => ???
    @attendee = Attendee.where(id: params[:id], user_id: current_user.id, event_id: params[:event_id])
    if @attendee.destroy_all
      @event = Event.find(params[:event_id])
      redirect_to event_path(@event)
    else
      flash[:notice] = "error"
    end
  end

  def attendee_params
    # event_idとuser_idが必要。
    params.permit(:event_id).merge(user_id: current_user.id)
  end
end
