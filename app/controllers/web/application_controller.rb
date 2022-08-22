# frozen_string_literal: true

module Web
  class ApplicationController < ::ApplicationController
    include ::Authentication
    include ::Authorization

    # rubocop:disable Rails/LexicallyScopedActionFilter
    after_action :set_referer_path, only: %i[new edit]

    # rubocop:enable Rails/LexicallyScopedActionFilter
    add_flash_types :success, :warning, :danger, :info

    def set_referer_path
      session[:referer_path] = request.referer
    end

    def referer_path
      session.delete :referer_path
    end
  end
end
