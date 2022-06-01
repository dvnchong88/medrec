class MedicalRecordPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def new?
    # record.patient == user.patient || user.user_type == "doctor"
    true
  end

  def create?
    record.patient == user.patient || user.user_type == "doctor"
  end

  def index?
    record.patient == user.patient || user.user_type == "doctor"
  end

  def show?
    record.patient == user.patient || user.user_type == "doctor"
  end

  def edit?
    record.patient == user.patient || user.user_type == "doctor"
  end

  def update?
    record.patient == user.patient || user.user_type == "doctor"
  end
end
