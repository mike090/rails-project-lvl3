# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy

  def create?
    signed_in?
  end

  def send_for_moderation?
    author?
  end

  def archive?
    author?
  end

  def update?
    author? && state_in?(:draft, :rejected)
  end

  def show?
    bulletin.published? || author?
  end

  private

  def bulletin
    @record
  end

  def state_in?(*states)
    bulletin.aasm.current_state.in? states
  end

  def author?
    bulletin.user_id == @user.id
  end

  class Scope < Scope
    def resolve
      scope.where(state: :published)
    end
  end
end
