# frozen_string_literal: true

module Admin
  class ApplicationPolicy < ::ApplicationPolicy
    def admin?
      return false unless @user.is_a? User

      @user.admin?
    end

    def index?
      true
    end

    def show?
      true
    end
  end
end
