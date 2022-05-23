class AddUserTypeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :user_type, :integer
    add_reference :patients, :user, foreign_key: true
    add_reference :doctors, :user, foreign_key: true
  end
end
