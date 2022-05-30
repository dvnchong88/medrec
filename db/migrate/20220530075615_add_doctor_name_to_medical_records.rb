class AddDoctorNameToMedicalRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :medical_records, :doctor_name, :string
  end
end
