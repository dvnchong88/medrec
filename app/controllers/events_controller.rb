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
