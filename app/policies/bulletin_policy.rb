# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def sent_for_moderation?
    author? && bulletin_state?(:draft, :rejected)
  end

  def publish?
    admin? && bulletin_state?(:under_moderation)
  end

  def reject?
    admin? && bulletin_state?(:under_moderation)
  end

  def archive?
    (author? || admin?) && !bulletin_state?(:archived)
  end

  def update?
    author? && bulletin_state?(:draft, :rejected)
  end

  def show?
    bulletin_state?(:published) || author? || admin?
  end

  def index?
    true
  end

  def create?
    @user.is_a? User
  end

  def admin_index?
    admin?
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
end
