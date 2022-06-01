class FixSymptomsInMedicalRecords < ActiveRecord::Migration[6.1]
  def change
    remove_column :medical_records, :symptoms, :text
    add_column :medical_records, :symptoms, :integer
  end
end
