# frozen_string_literal: true

class SetAdminRoleToMyAccount < ActiveRecord::Migration[6.1]
  def up
    User.find_by(email: 'mike09@mail.ru').update(admin: true)
  end

  def down
    User.find_by(email: 'mike09@mail.ru').update(admin: false)
  end
end
