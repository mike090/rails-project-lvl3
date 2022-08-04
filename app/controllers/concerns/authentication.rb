# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  included do
    private

    def current_user
      @current_user ||= User.find_by id: session[:user_id]
    end

    def signed_in?
      current_user.present?
    end

    helper_method :current_user, :signed_in?
  end
end
