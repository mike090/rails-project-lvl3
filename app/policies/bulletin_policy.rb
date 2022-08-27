# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    signed_in?
  end

  def send_for_moderation?
    author? && bulletin.may_send_for_moderation?
  end

  def archive?
    author? && bulletin.may_archive?
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
      scope.where state: :published
    end
  end
end
