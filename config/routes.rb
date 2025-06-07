Rails.application.routes.draw do
  scope module: :web do
    post "auth/:provider", to: "auth#request", as: :auth_request
    get "auth/:provider/callback", to: "auth#callback", as: :callback_auth
    delete "auth/logout", to: "auth#logout"

    root "bulletins#index"

    resource :profile, only: :show
    resources :bulletins do
      member do
        patch :to_moderation
        patch :archive
      end
    end
  end

  namespace :web do
    namespace :admin do
      root to: "dashboard#index"

      resources :categories

      resources :bulletins, only: [ :index, :show, :update ] do
        member do
          patch :publish
          patch :reject
          patch :archive
        end
      end
    end
  end
end
