# frozen_string_literal: true

module Web
  class AuthController < ApplicationController
    def callback
      auth = request.env['omniauth.auth']
      user = User.find_or_initialize_by(email: auth.info.email.downcase)

      user.name = auth.info.name
      user.save!

      session[:user_id] = user.id
      redirect_to root_path, notice: t('auth.callback.success', name: user.name)
    end

    def logout
      reset_session
      redirect_to root_path, notice: t('auth.logout.success')
    end
  end
end
