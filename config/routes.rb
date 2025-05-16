Rails.application.routes.draw do
  root "home#index"
  get "home/index"
  get "/about", to: "home#about"
  post "auth/:provider", to: "auth#request", as: :auth_request
  get "auth/:provider/callback", to: "auth#callback", as: :callback_auth
end
