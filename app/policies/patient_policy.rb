class PatientPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def update?
    true
  end

  def show?
    true
  end

  def edit?
    true
  end

  def confirm?
    true
  end

  def autofill?
    true
  end
end
