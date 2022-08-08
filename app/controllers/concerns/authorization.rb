# frozen_string_literal: true

# frozen_sring_literal: true

module Authorization
  extend ActiveSupport::Concern

  included do
    include Pundit::Authorization

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorezed

    private

    def user_not_authorezed
      direction = request.referer || root_path
      redirect_to direction, warning: t('global.flash.not_authorized')
    end
  end
end
