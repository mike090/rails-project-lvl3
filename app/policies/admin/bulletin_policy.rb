# frozen_string_literal: true

module Admin
  class BulletinPolicy < ApplicationPolicy
    def archive?
      bulletin.aasm.may_fire_event? :archive
    end

    def publish?
      bulletin.aasm.may_fire_event? :publish
    end

    def reject?
      bulletin.aasm.may_fire_event? :reject
    end

    private

    def bulletin
      @record
    end
  end
end
