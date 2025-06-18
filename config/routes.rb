Rails.application.routes.draw do
  scope module: :web do
    post "auth/:provider", to: "auth#redirect_to_provider", as: :auth_request
    get "auth/:provider/callback", to: "auth#callback", as: :callback_auth
    delete "auth/logout", to: "auth#logout"

    root "bulletins#index"

    resource :profile, only: :show
    resources :bulletins do
      member do
        patch :publish
        patch :to_moderation
        patch :archive
        get :edit
        patch :update
      end
    end

    namespace :admin do
      root to: "bulletins#index"
      resources :categories, only: [ :index, :new, :create, :edit, :update, :destroy ]
      resources :bulletins, only: [ :index, :show ] do
        member do
          patch :publish
          patch :reject
          patch :archive
        end
      end
    end
  end
end
