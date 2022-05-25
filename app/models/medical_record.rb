class MedicalRecord < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor, optional: true
  has_many_attached :photos
  enum creator: { patient: 0, doctor: 1 }
end
