class Doctor < ApplicationRecord
  has_many :medical_records
  has_many :patients, through: :medical_records
  belongs_to :user
  has_one_attached :photo
  enum specialty: {
    Dermatology: 0,
    Emergrency: 1,
    Family: 2,
    Internal: 3,
    Neurology: 4,
    Obstetrics: 5,
    Ophthalmaolgy: 6,
    Pathology: 7,
    Pediatrics: 8,
    Psychiatry: 9,
    Surgery: 10,
    Urology: 11
  }
end
