class PatientsController < ApplicationController
  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)
    @patient.user = current_user
    if @patient.save
      redirect_to patient_path(@patient)
    else
      render :new
    end
  end

  def edit
    @patient = Patient.find(params[:id])
    authorize @patient
  end

  def update
    @patient = Patient.find(params[:id])
    authorize @patient
    if @patient.update(patient_params)
      redirect_to patient_path(@patient), notice: 'Personal Info was successfully updated.'
    else
      render :edit
    end
  end

  def autofill
    @patient = Patient.find(params[:id])
    authorize @patient
    @patient.update(patient_params)
    if Rails.env == "development"
      image = "https://res.cloudinary.com/dystex7k9/image/upload/v1/development/#{@patient.id_card.key}"#helpers.url_for(@cosmetic.cosmetic_image)
    else
      image = "https://res.cloudinary.com/dystex7k9/image/upload/v1/production/#{@patient.id_card.key}"
    end
    @info = Ocr.extract_text(image)
  end

  def show
    @patient = Patient.find(params[:id])
    authorize @patient
  end

  private

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :date_of_birth, :sex, :blood_type, :height, :weight, :allergies, :address, :phone_number, :emergency_contact, :smoker, :user, :photo, :id_card )
  end
end
