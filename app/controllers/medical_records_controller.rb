class MedicalRecordsController < ApplicationController
  def index
    @medical_records = policy_scope(MedicalRecord.where(patient_id: current_user.id))
  end

  def new
    @medical_record = MedicalRecord.new
    authorize @medical_record
  end

  def create
    @medical_record = MedicalRecord.new(record_params)
    @medical_record.patient = current_user
    authorize @medical_record

    if @medical_record.save
      redirect_to "medical_records/show"
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
    params.require(:medical_record).permit(:patient_id, :doctor_id, :diagnosis, :symptoms, :photos, :creator, :prescribed_medications)
end