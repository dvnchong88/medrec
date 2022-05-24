class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :patient
  has_one :doctor
  enum user_type: { patient: 0, doctor: 1 }
  has_one :patient
  has_one :doctor
end
