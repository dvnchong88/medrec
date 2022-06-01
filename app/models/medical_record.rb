class MedicalRecord < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor, optional: true, default: false
  has_many_attached :photos
  enum creator: { patient: 0, doctor: 1 }
  enum symptoms: {
    "I have fever" => 0,
    "I have a stomach ache" => 1,
    "I am sick" => 2,
    "I have a diarrhea" => 3,
    "I am vomiting" => 5,
    "I have a runny nose" => 6,
    "I have a cough" => 7,
    "I have a pharynx pain" => 8,
    "I have a headache" => 9,
    "Others. Please describe." => 6
  }
end
