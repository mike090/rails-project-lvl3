# frozen_string_literal: true

module Web
  class AuthController < ApplicationController
    def callback
      user_info = request.env['omniauth.auth'].info
      user = User.find_or_initialize_by email: user_info.email.downcase
      user.update! name: user_info.name
      self.current_user = user
      redirect_to root_path, success: t('.welcome')
    end

    def sign_out
      session.delete :user_id
      @current_user = nil
      redirect_to root_path, success: t('.goodbye')
    end

    private

    def current_user=(user)
      session[:user_id] = user.id
      @current_user = user
    end
  end
end
