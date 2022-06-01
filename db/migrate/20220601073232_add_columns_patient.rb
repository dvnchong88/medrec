class AddColumnsPatient < ActiveRecord::Migration[6.1]
  def change
    add_column :patients, :traveled_from_abroad, :boolean
    add_column :patients, :family_health_problems, :string, array: true, default: []
    add_column :patients, :usual_medication, :string, array: true, default: []
    add_column :patients, :pregnancy, :boolean
    add_column :patients, :lactation, :boolean
  end
end
