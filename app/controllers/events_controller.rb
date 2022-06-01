class EventsController < ApplicationController
  def index
    @events = policy_scope(Event.where(patient_id: current_user.patient.id))
  end

  def new
    @event = Event.new
    @patient = Patient.find(params[:patient_id])
    authorize @event
  end

  def show
    @event = Event.find(params[:id])
    authorize @event
  end

  def create
    @event = Event.new(record_params)
    @event.patient = current_user.patient
    start_time = params[:event][:start_time].split(":")
    end_time = params[:event][:end_time].split(":")
    today = params[:today].split("-")
    year = today[0].to_i
    month = today[1].to_i
    day = today[2].to_i
    start_hour = start_time[0].to_i
    start_minutes = start_time[1].to_i
    end_hour = end_time[0].to_i
    end_minutes = end_time[1].to_i
    @event.start_time = DateTime.new(year, month, day, start_hour, start_minutes)
    @event.end_time = DateTime.new(year, month, day, end_hour, end_minutes)
    authorize @event

    if @event.save

      redirect_to calendar_path, notice: 'Event was saved.'
    else
      render :new, notice: 'Event was not saved. Please try again.'
    end
  end

  def edit
    @event = Event.find(params[:id])
    authorize @event
  end

  def update
    # raise StandardError, 'NotAuthorized' unless @restaurant.user == current_user
    @event = Event.find(params[:id])
    authorize @event
    if @event.update(record_params)
      redirect_to patient_events_path(current_user.patient), notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    authorize @event
    @event.destroy
    redirect_to "events/index", notice: "Are you sure you'd like to delete this event?"
  end

  private

  def record_params
    params.require(:event).permit(:patient_id, :title, :start_time, :end_time, :notes, :location)
  end
end
