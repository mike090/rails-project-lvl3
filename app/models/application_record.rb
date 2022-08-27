# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def state_in?(*states)
    return false unless self.class.include? AASM

    aasm.current_state.in? states
  end
end
