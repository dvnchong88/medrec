class AddNationalityToPatient < ActiveRecord::Migration[6.1]
  def change
    add_column :patients, :nationality, :integer
  end
end
