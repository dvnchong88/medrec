class Patient < ApplicationRecord
  has_many :medical_records, dependent: :destroy
  has_many :doctors, through: :medical_records
  has_one_attached :photo
  belongs_to :user

  validates :first_name, presence: true
  enum sex: { "non-binary" => 0, female: 1, male: 2 }

end
