class ChangeMedicalRecord < ActiveRecord::Migration[6.1]
  def change
    remove_reference :medical_records, :doctor
    add_reference :medical_records, :doctor, foreign_key: true
  end
end
