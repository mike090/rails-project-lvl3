# frozen_string_literal: true

module Web
  class ProfilesController < ApplicationController
    def show
      require_authentication
      @bulletins = current_user.bulletins
    end
  end
end
