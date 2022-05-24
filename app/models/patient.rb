class Patient < ApplicationRecord
  has_many :medical_records, dependent: :destroy
  has_many :doctors, through: :medical_records
  has_one_attached :photo
  validates :first_name, presence: true
  belongs_to :user
end
