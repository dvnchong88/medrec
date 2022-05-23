class CreateMedicalRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :medical_records do |t|
      t.references :patient, null: false, foreign_key: true
      t.references :doctor, null: false, foreign_key: true
      t.boolean :creator
      t.text :symptoms
      t.text :diagnosis
      t.string :prescribed_medicine

      t.timestamps
    end
  end
end
