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

    def allow?(action, resource)
      policy(resource).public_send("#{action}?") && assm_allow?(action, resource)
    end

    private

    def assm_allow?(action, resource)
      return true unless resource.class.include? AASM

      return true unless action.in?(resource.class.aasm.events.map(&:name))

      resource.aasm.may_fire_event? action
    end

    helper_method :allow?
  end
end
