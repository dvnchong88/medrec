class ChangeUsualMedicationHealthInPatients < ActiveRecord::Migration[6.1]
  def change
    remove_column :patients, :usual_medication, :string, array: true, default: []
    add_column :patients, :usual_medication, :string
  end
end
