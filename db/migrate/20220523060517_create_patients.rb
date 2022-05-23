class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.string :last_name
      t.string :first_name
      t.date :date_of_birth
      t.string :sex
      t.string :blood_type
      t.integer :height
      t.integer :weight
      t.string :allergies
      t.string :address
      t.string :phone_number
      t.string :emergency_contact
      t.boolean :smoker

      t.timestamps
    end
  end
end
