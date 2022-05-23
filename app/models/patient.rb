class Patient < ApplicationRecord
  has_many :medical_records
  has_many :doctors, through: :medical_records
end
