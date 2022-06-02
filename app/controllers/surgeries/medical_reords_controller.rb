class Surgeries::MedicalReordsController < ApplicationController
  def index
    @medical_records = MedicalRecord.where(type: "surgeries")
  end
end
