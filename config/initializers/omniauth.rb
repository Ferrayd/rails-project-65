Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github,
           ENV["GITHUB_CLIENT_ID"],
           ENV["GITHUB_CLIENT_SECRET"],
           scope: "user",
           callback_url: "#{ENV['HOST']}/auth/github/callback"
end
