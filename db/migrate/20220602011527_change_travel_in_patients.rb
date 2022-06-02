class ChangeTravelInPatients < ActiveRecord::Migration[6.1]
  def change
    add_column :patients, :health_problems, :string
  end
end
