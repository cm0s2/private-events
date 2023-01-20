class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ new create update destroy ]

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

  # TODO: Make sure edit and update checks that event.craetor = current_user

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
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :date, :location)
    end
end
