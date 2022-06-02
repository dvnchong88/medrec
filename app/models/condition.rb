class Condition < ApplicationRecord
  has_many :medical_records
  belongs_to :patient
end
