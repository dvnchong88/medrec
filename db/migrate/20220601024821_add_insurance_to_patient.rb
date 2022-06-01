class AddInsuranceToPatient < ActiveRecord::Migration[6.1]
  def change
    add_column :patients, :insurance, :integer
  end
end
