class Doctor::MedicalRecordsController < ApplicationController
  def index
    @medical_records = MedicalRecord.where(MedicalRecord.doctor == current_user.doctor)
    # @medical_records = policy_scope([:doctor, MedicalRecord]).order(date: :desc)
  end
end
