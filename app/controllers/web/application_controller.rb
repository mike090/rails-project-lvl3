# frozen_string_literal: true

module Web
  class ApplicationController < ::ApplicationController
    include ::Authentication
    include ::Authorization

    add_flash_types :success, :warning

    def set_referer_path
      session[:referer_path] = request.referer
    end

    def referer_path
      session.delete :referer_path
    end
  end
end
