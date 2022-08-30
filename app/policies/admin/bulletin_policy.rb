# frozen_string_literal: true

module Admin
  class BulletinPolicy < ApplicationPolicy
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
