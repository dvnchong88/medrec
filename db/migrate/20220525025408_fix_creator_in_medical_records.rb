class FixCreatorInMedicalRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :medical_records, :creator, :integer
  end
end
