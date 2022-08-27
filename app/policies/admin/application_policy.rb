# frozen_string_literal: true

module Admin
  class ApplicationPolicy < ::ApplicationPolicy
    def admin?
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
