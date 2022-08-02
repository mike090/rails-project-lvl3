module Web
  class AuthController < ApplicationController
    def request

    end

    def callback
      byebug
      user_info = request.env['omniauth.auth']
      raise user_info # Your own session management should be placed here.
    end
  end
end