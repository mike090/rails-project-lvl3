# frozen_string_literal: true

class SetAdminRoleToMyAccount < ActiveRecord::Migration[6.1]
  def up
    user = User.find_by(email: 'mike09@mail.ru') || User.create(name: 'mike09', email: 'mike09@mail.ru')
    user.admin = true
    user.save
  end

  def down
    User.find_by(email: 'mike09@mail.ru').update(admin: false)
  end
end
