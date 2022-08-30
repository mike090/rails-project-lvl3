# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

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
    author? && bulletin.state_in?(:draft, :rejected)
  end

  def show?
    bulletin.published? || author?
  end

  private

  def bulletin
    @record
  end

  def author?
    bulletin.user_id == @user.id
  end

  class Scope < Scope
    def resolve
      scope.where(state: :published).or(scope.where(user_id: user.id))
    end
  end
end
