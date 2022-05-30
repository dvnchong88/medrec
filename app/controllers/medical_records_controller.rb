require "rqrcode"

class MedicalRecordsController < ApplicationController
  def index
    @medical_records = policy_scope(MedicalRecord.where(patient_id: current_user.patient.id)).order(created_at: :desc)
  end

  def new
    @medical_record = MedicalRecord.new
    @patient = Patient.find(params[:patient_id])
    authorize @medical_record
  end

  def show
    @medical_record = MedicalRecord.find(params[:id])
    authorize @medical_record
  end

  def create
    @medical_record = MedicalRecord.new(record_params)
    @medical_record.patient = Patient.find(params[:patient_id])
    # @medical_record.doctor = Doctor.all.sample
    @medical_record.creator = current_user.user_type
    authorize @medical_record

    if @medical_record.save
      redirect_to patient_medical_records_path(@medical_record), notice: 'Record was saved.'
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
    authorize @medical_record
    if @medical_record.update(record_params)
      redirect_to patient_medical_records_path(current_user.patient), notice: 'Record was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @medical_record = MedicalRecord.find(params[:id])
    authorize @medical_record
    @medical_record.destroy
    redirect_to "medical_records/index", notice: "Are you sure you'd like to delete this record? If deleted, it cannot be restored"
  end

  private

  def record_params
    params.require(:medical_record).permit(:patient_id, :doctor_id, :doctor_name, :diagnosis, :symptoms, :creator, :date, :prescribed_medicine, photos: [])
  end
end
