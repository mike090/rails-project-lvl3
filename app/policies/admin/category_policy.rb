# frozen_string_literal: true

class Admin::CategoryPolicy < Admin::ApplicationPolicy
  def destroy?
    category.bulletins.empty?
  end

  def update?
    true
  end

  private

  def category
    @record
  end
end
