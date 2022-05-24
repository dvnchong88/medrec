class AddDateToMedicalRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :medical_records, :date, :date
  end
end
