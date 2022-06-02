class PhysicalInjuries::MedicalRecordsController < ApplicationController
  def index
    @medical_records = MedicalRecord.where(type: "physical_injuries")
  end
end
