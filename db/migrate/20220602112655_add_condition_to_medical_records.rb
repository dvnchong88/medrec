class AddConditionToMedicalRecords < ActiveRecord::Migration[6.1]
  def change
    add_reference :medical_records, :condition, foreign_key: true
  end
end
