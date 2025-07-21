# frozen_string_literal: true

module Web
  class ApplicationController < ApplicationController
    helper_method :current_user, :signed_in?

    rescue_from ActiveRecord::RecordNotFound do
      redirect_to root_path, alert: t('bulletins.not_found')
    end

    private

    def authenticate_user!
      redirect_to root_path, alert: t('profiles.authenticate.alert') unless current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def signed_in?
      current_user.present?
    end
  end
end
