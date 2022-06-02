require "rqrcode"

class MedicalRecordsController < ApplicationController
  def index
    @patient = current_user.doctor? ? Patient.find(params[:patient_id]) : current_user.patient.id
    @medical_records = policy_scope(MedicalRecord.where(patient: @patient)).order(date: :desc)
  end

  def new
    @medical_record = MedicalRecord.new
    @medical_record.patient = Patient.find(params[:patient_id])
    authorize @medical_record
  end

  def show
    @medical_record = MedicalRecord.find(params[:id])
    authorize @medical_record
    if Rails.env == "development"
      image = "https://res.cloudinary.com/dfgn4wbuz/image/upload/v1654146615/development/#{@medical_record.photo_form.key}"#helpers.url_for(@cosmetic.cosmetic_image)
    else
      image = "https://res.cloudinary.com/dfgn4wbuz/image/upload/v1654146615/production/#{@medical_record.photo_form.key}"
    end
    @infos = Ocr.locate_text(image, @medical_record.patient)
  end

  def create
    @medical_record = MedicalRecord.new(record_params)
    @patient = Patient.find(params[:patient_id])
    @medical_record.patient = @patient
    @medical_record.creator = current_user.user_type
    @medical_record.date = Date.today
    @medical_record.doctor = current_user.doctor? ? current_user.doctor : nil
    # params[:medical_record][:symptoms].each do |symptom|
    #   @medical_record.symptoms.push(symptom) if symptom != ""
    # end

    authorize @medical_record

    if @medical_record.save
      redirect_to patient_medical_record_path(@medical_record.patient, @medical_record), notice: 'Record was saved.'
    else
      render :new, notice: 'Record was not saved. Please try again.'
    end
  end

  def edit
    @medical_record = MedicalRecord.find(params[:id])
    authorize @medical_record
  end

  def update
    # raise StandardError, 'NotAuthorized' unless @restaurant.user == current_user
    @medical_record = MedicalRecord.find(params[:id])
    params[:medical_record][:symptoms].each do |symptom|
      @medical_record.symptoms.push(symptom) if symptom != ""
    end
    authorize @medical_record
    if @medical_record.update(record_params)
      redirect_to patient_medical_records_path(@medical_record.patient), notice: 'Record was successfully updated.'
    else
      render :edit
    end
  end

  def autofill
    @medical_record = MedicalRecord.new(record_params)
    @medical_record.patient = Patient.find(params[:patient_id])
    @medical_record.creator = current_user.user_type
    @medical_record.date = Date.today
    @medical_record.doctor = current_user.doctor? ? current_user.doctor : nil
    params[:medical_record][:symptoms].each do |symptom|
      @medical_record.symptoms.push(symptom) if symptom != ""
    end

    authorize @medical_record
    @patient = Patient.find(params[:id])
    authorize @patient
    @patient.update(patient_params)
    if Rails.env == "development"
      image = "https://res.cloudinary.com/dfgn4wbuz/image/upload/v1654146615/development/#{@patient.id_card.key}"#helpers.url_for(@cosmetic.cosmetic_image)
    else
      image = "https://res.cloudinary.com/dfgn4wbuz/image/upload/v1654146615/production/#{@patient.id_card.key}"
    end
    @infos = Ocr.locate_text(image, @patient)
    render "medical_records/ocr_form.html"
  end

  def destroy
    @medical_record = MedicalRecord.find(params[:id])
    authorize @medical_record
    @medical_record.destroy
    redirect_to "medical_records/index", notice: "Are you sure you'd like to delete this record? If deleted, it cannot be restored"
  end

  private

  def record_params
    params.require(:medical_record).permit(:patient_id, :doctor_id, :photo_form, :doctor_name, :diagnosis, :symptoms, :creator, :date, :prescribed_medicine, photos: [])
  end
end
