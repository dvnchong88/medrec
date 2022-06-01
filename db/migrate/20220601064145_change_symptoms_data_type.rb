class ChangeSymptomsDataType < ActiveRecord::Migration[6.1]
  def change
    remove_column :medical_records, :symptoms, :integer
    add_column :medical_records, :symptoms, :string, array: true, default: []
  end
end
