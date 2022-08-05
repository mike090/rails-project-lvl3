# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    namespace :admin do
      root 'bulletins#index'
      resources :categiries
      resources :bulletins
    end

    resources :bulletins

    root 'home#index'
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    get 'auth/sing_out', as: :sing_out
  end
end
