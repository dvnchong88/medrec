class ChronicIllnesses::MedicalRecordsController < ApplicationController
  def index
    @medical_records = MedicalRecord.where(type: "chronic_illnesses")
  end
end
