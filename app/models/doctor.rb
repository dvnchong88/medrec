class Doctor < ApplicationRecord
  has_many :medical_records
  has_many :patients, through: :medical_records
  has_one :user
end
