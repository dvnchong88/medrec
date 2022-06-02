class ChangeFamilyHealthInPatients < ActiveRecord::Migration[6.1]
  def change
    remove_column :patients, :family_health_problems, :string, array: true, default: []
    add_column :patients, :family_health_problems, :string
  end
end
