require "rqrcode"

class MedicalRecordsController < ApplicationController
  def index
    @medical_records = policy_scope(MedicalRecord.where(patient_id: current_user.patient.id))
    @qr_code = RQRCode::QRCode.new(record_params)
    @svg = @qr_code.as_svg(
      offset: 0,
      color: '000',
      shape_rendering: 'crispEdges',
      standalone: true,
      use_path: true
    )
  end

  def new
    @medical_record = MedicalRecord.new
    @patient = Patient.find(params[:patient_id])
    authorize @medical_record
  end

  def show
    @medical_record = MedicalRecord.find(params[:id])
  end

  def create
    @medical_record = MedicalRecord.new(record_params)
    @medical_record.patient = Patient.find(params[:patient_id])
    @medical_record.doctor = Doctor.first
    @medical_record.creator = current_user.user_type
    authorize @medical_record

    if @medical_record.save
      redirect_to patient_medical_records_path(@medical_record)
    else
      render :new
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
      redirect_to medical_records_path, notice: 'Record was successfully updated.'
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
    params.require(:medical_record).permit(:patient_id, :doctor_id, :diagnosis, :symptoms, :creator, :date, :prescribed_medicine, :name, :address, :qr_code, photos: [])
  end
end
