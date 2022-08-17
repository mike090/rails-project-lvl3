# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    namespace :admin do
      root 'categories#index'
      resources :categories, only: %i[index new create edit update destroy]
      resources :bulletins, only: %i[index] do
        collection do
          get 'moderate'
        end
        member do
          put 'publish'
          put 'reject'
        end
      end
    end

    resources :bulletins, only: %i[index new create show edit update] do
      member do
        put 'sent_for_moderation'
        put 'archive'
      end
    end

    resource :profile, only: :show

    root 'bulletins#index'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/sing_out', as: :sing_out
  end
end
