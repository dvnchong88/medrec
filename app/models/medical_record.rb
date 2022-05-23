class MedicalRecord < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor
  has_many_attached :photos
end
