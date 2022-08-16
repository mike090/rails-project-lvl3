# frozen_string_literal: true

class ChangeBulletinsStateNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :bulletins, :state, false
  end
end
