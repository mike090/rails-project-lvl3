# frozen_string_literal: true

module Admin
  class ApplicationPolicy < ::ApplicationPolicy
    def admin?
      @user.admin?
    end
  end
end
