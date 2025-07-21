# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    post 'auth/:provider', to: 'auth#redirect_to_provider', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/logout', to: 'auth#logout'

    root 'bulletins#index'

    resource :profile, only: :show
    resources :bulletins, except: [:destroy] do
      member do
        patch :to_moderation
        patch :archive
      end
    end

    namespace :admin do
      root to: 'bulletins#index'
      resources :categories, only: %i[index new create edit update destroy]
      resources :bulletins, only: %i[index show] do
        collection do
          get :all
        end
        member do
          patch :publish
          patch :reject
          patch :archive
        end
      end
    end
  end
end
