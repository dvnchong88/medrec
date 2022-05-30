class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :patient
  has_one :doctor
  enum user_type: { patient: 0, doctor: 1 }
  after_create :create_profile
  has_one_attached :photo

  private

  def create_profile
    if patient?
      patient = Patient.new(user: self)
      patient.save(validate: false)
    else
      doctor = Doctor.new(user: self)
      doctor.save(validate: false)
    end
  end
end
