class DosePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.cocktail.user_id == user[:id]
  end

  def destroy?
    record.cocktail.user_id == user[:id]
  end
end
