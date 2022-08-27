# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    namespace :admin do
      root 'bulletins#moderate'

      resources :categories, only: %i[index new create edit update destroy]

      resources :bulletins, only: %i[index show] do
        collection do
          get 'moderate'
        end
        member do
          patch 'publish'
          patch 'reject'
          patch 'archive'
        end
      end
    end

    resources :bulletins, only: %i[index new create show edit update] do
      member do
        patch 'send_for_moderation'
        patch 'archive'
      end
    end

    resource :profile, only: :show

    root 'bulletins#index'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/sign_out', as: :sign_out
  end
end
