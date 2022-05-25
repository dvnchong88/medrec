class FixCreatorInMedicalRecords < ActiveRecord::Migration[6.1]
  def change
    remove_column :medical_records, :creator
    add_column :medical_records, :creator, :integer
  end
end
