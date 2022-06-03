class ConditionPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.patient?
      scope.where(patient: user.patient)
      else
        scope.all
      end
    end
  end

  def index?
    true
  end

  def create?
    true
  end

  def show?
    true
  end
end
