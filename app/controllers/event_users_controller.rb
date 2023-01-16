class EventUsersController < ApplicationController
  before_action :authenticate_user!

  def create
    event = Event.find(params[:event_id])
    event_user = EventUser.new(attendee_id: current_user.id, attended_event_id: event.id)

    if event_user.save
      flash[:notice] = "You joined the event"
      redirect_to events_path(event)
    else
      redirect_to events_path(event)
    end
  end

  def destroy

  end

  def update
  
  end
end
