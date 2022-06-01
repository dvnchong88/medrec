class Doctor::MedicalRecordPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
    def resolve
      user.medical_records_as_doctor
      # For a multi-tenant SaaS app, you may want to use:
      # scope.where(user: user)
    end
  end
end
