class Web::AuthController < ApplicationController
  def request
    redirect_to "/auth/#{params[:provider]}"
  end

  def callback
    auth = request.env["omniauth.auth"]

    user = User.find_or_initialize_by(provider: auth["provider"], uid: auth["uid"])
    user.email = auth["info"]["email"]&.downcase
    user.name  = auth["info"]["name"]
    user.save!

    session[:user_id] = user.id
    redirect_to root_path, notice: "Successfully signed in!"
  rescue StandardError => e
    Rails.logger.error("OAuth callback error: #{e.message}")
    redirect_to root_path, alert: "Failed to sign in"
  end
end
