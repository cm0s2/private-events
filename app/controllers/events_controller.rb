class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ new create update destroy ]
  before_action :require_permission, only: %i[ edit update destroy ]
  before_action :require_invite, only: %i[ show ]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = current_user.events.new
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to root_path, notice: "Event was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to event_url(@event), notice: "Event was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy

    redirect_to user_path(current_user), notice: "Event was successfully deleted"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def require_permission
      if Event.find(params[:id]).creator != current_user
        redirect_to events_path, flash: {alert: "You do not have permission to do that."}
      end
    end

    def require_invite
      unless @event.attendees.where(id: current_user.id).any? || Event.find(params[:id]).creator == current_user
        # User.where.not(id: attendees.ids)
        redirect_to events_path, flash: {alert: "You have not been invited to this event."}
      end
    end

    def event_params
      params.require(:event).permit(:name, :date, :location)
    end
end
