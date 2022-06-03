class General::ConditionsController < ApplicationController
  def index
    if current_user.patient
      @medical_records = MedicalRecord.where(condition: nil, patient: current_user.patient).order(date: :desc)
    else
      @medical_records = MedicalRecord.where(condition: nil, patient: Patient.find(226)).order(date: :desc)
    end
  end
end
