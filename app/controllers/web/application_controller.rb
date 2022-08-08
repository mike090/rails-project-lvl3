# frozen_string_literal: true

module Web
  class ApplicationController < ::ApplicationController
    include ::Authentication
    include Pundit::Authorization

    add_flash_types :success, :warning, :danger, :info

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorezed

    private

    def user_not_authorezed
      flash[:danger] = t('permission_denied')
      redirect_to(request.referer || root_path)
    end
  end
end
