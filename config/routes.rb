Rails.application.routes.draw do
  scope module: :web do
    post "auth/:provider", to: "auth#request", as: :auth_request
    get "auth/:provider/callback", to: "auth#callback", as: :callback_auth
    delete "auth/logout", to: "auth#logout"

    root "bulletins#index"
  end

  namespace :web do
    resources :bulletins, only: [ :index, :new, :create ]
    get "sign_in", to: "sessions#new"
    post "sign_in", to: "sessions#create"
    delete "sign_out", to: "sessions#destroy"

    namespace :admin do
      resources :categories
      resources :bulletins
      root to: "dashboard#index"
    end
  end
end
