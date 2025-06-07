class Web::AuthController < ApplicationController
  def request
    redirect_to "/auth/#{params[:provider]}"
  end

  def callback
    auth = request.env["omniauth.auth"]
    user = User.find_or_initialize_by(email: auth.info.email.downcase)

    user.name = auth.info.name
    user.save!

    session[:user_id] = user.id
    redirect_to root_path, notice: "Вы вошли как #{user.name}"
  end
end
