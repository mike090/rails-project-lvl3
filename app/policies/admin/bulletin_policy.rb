# frozen_string_literal: true

module Admin
  # we need all these policies to make method “allow?” working
  class BulletinPolicy < ApplicationPolicy
    def show?
      true
    end

    def archive?
      true
    end

    def publish?
      true
    end

    def reject?
      true
    end
  end
end
