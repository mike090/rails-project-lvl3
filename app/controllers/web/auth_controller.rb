# frozen_string_literal: true

module Web
  class AuthController < ApplicationController
    def callback
      user = find_or_create_user
      sign_in user
      redirect_to root_path
    end

    def sing_out
      session.delete :user_id
      @current_user = nil
      redirect_to root_path
    end

    private

    def find_or_create_user
      user_info = request.env['omniauth.auth'].info
      user = User.find_by(email: user_info.email.downcase)
      unless user
        user = User.create! name: user_info.name, email: user_info.email.downcase
        user.reload
      end
      user
    end

    def sign_in(user)
      session[:user_id] = user.id
      @current_user = user
    end
  end
end
