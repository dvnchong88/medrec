class MedicalRecord < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor, optional: true
  has_many_attached :photos
end
