# frozen_string_literal: true

class FillBulletinsState < ActiveRecord::Migration[6.1]
  def up
    states = Bulletin.aasm.states.map(&:name)
    Bulletin.all.each do |bulletin|
      bulletin.state = states.sample.to_s
      bulletin.save
    end
  end

  # rubocop:disable Rails/SkipsModelValidations
  def down
    Bulletin.update_all state: nil
  end
  # rubocop:enable Rails/SkipsModelValidations
end
