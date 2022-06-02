class MedicalRecord < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor, optional: true, default: false
  has_many_attached :photos
  belongs_to :condition, optional: true
  has_one_attached :photo_form
  enum creator: { patient: 0, doctor: 1 }
  enum type: { chronic_illnesses: 0, surgeries: 1, physical_injuries: 2 }

  SYMPTOMS = [
    "I have fever",
    "I have a stomach ache",
    "I am sick",
    "I have a diarrhea",
    "I am vomiting",
    "I have a runny nose",
    "I have a cough",
    "I have a pharynx pain",
    "I have a headache",
    "Others. Please describe."
  ]
end
