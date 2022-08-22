# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    @user.is_a? User
  end

  def sent_for_moderation?
    author? && bulletin.aasm.may_fire_event?(:sent_for_moderation)
  end

  def archive?
    author? && bulletin.aasm.may_fire_event?(:archive)
  end

  def update?
    author? && bulletin_state?(:draft, :rejected)
  end

  def show?
    bulletin_state?(:published) || author?
  end

  private

  def bulletin
    @record
  end

  def author?
    return false if @user.is_a? GuestUser

    bulletin.user_id == @user.id
  end

  def bulletin_state?(*states)
    states.find { |state| bulletin.aasm.current_state == state }
  end

  class Scope < Scope
    def resolve
      scope.where state: :published
    end
  end
end
