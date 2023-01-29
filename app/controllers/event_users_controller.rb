class EventUsersController < ApplicationController
  before_action :authenticate_user!

  def create
    event = Event.find(params[:event_id])
    event_user = EventUser.new(attendee_id: params[:attendee_id], attended_event_id: event.id)

    if event_user.save
      flash[:notice] = "You joined the event"
      redirect_to event_path(event)
    else
      flash[:alert] = "Error? #{params[:attendee_id]}"
      redirect_to event_path(event)
    end
  end

  def update
    @event_user = EventUser.find(params[:id])

    if @event_user.update(status: params[:status])
      redirect_to event_url(@event_user.attended_event), notice: "You've accepted the event"
    else
      redirect_to event_url(@event_user.attended_event), alert: "Could not do this"
    end
  end

  def destroy
    event_user = EventUser.find(params[:id])
    event = event_user.attended_event
    event_user.destroy

    redirect_to event_path(event)
  end

  private
    def event_user_params
      params.require(:event_user).permit(:status)
    end
end
