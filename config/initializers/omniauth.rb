# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github,
           ENV.fetch('GITHUB_CLIENT_ID', nil),
           ENV.fetch('GITHUB_CLIENT_SECRET', nil),
           scope: 'user',
           callback_url: "#{ENV.fetch('HOST', nil)}/auth/github/callback"
end
