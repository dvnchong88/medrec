class DoctorsController < ApplicationController
  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)
    @doctor.user = current_user
    if @doctor.save
      redirect_to doctor_path(@doctor)
    else
      render :new
    end
  end

  def edit
    @doctor = Doctor.find(params[:id])
    authorize @doctor
  end

  def update
    @doctor = Doctor.find(params[:id])
    authorize @doctor
    if @doctor.update(doctor_params)
      redirect_to doctor_path(@doctor), notice: 'Doctor Info was successfully updated.'
    else
      render :edit
    end
  end

  def show
    @doctor = Doctor.find(params[:id])
    authorize @doctor
  end

  private

  def doctor_params
    params.require(:doctor).permit(:first_name, :last_name, :license_number, :specialty, :clinic_name, :photo)
  end
end
