# frozen_string_literal: true

module Admin
  class BulletinPolicy < ApplicationPolicy
    def archive?
      bulletin.may_archive?
    end

    def publish?
      bulletin.may_publish?
    end

    def reject?
      bulletin.may_reject?
    end

    private

    def bulletin
      @record
    end
  end
end
