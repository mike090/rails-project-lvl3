# frozen_string_literal: true

module Web
  class ProfilesController < ApplicationController
    def show
      require_authentication
      @bulletins = current_user.bulletins.order created_at: :desc
    end
  end
end
