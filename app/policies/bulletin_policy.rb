# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def update?
    bulletin.user == @user
  end

  private

  def bulletin
    @record
  end
end
