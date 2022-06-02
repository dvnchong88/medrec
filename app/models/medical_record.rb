class MedicalRecord < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor, optional: true, default: false
  has_many_attached :photos
  has_one_attached :photo_form
  enum creator: { patient: 0, doctor: 1 }
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
