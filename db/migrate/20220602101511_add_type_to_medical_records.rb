class AddTypeToMedicalRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :medical_records, :type, :string
  end
end
