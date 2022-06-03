class General::ConditionsController < ApplicationController
  def index
    @medical_records = MedicalRecord.where(condition: nil, patient: current_user.patient)
  end
end
