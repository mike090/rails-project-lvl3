# frozen_string_literal: true

class Admin::CategoryPolicy < Admin::ApplicationPolicy
  def destroy?
    !category.bulletins.exists?
  end

  def edit?
    true
  end

  private

  def category
    @record
  end
end
