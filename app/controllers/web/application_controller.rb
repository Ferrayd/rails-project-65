# frozen_string_literal: true

module Web
  class ApplicationController < ApplicationController
    include Pundit::Authorization
    helper_method :current_user, :signed_in?

    rescue_from ActiveRecord::RecordNotFound do
      redirect_to root_path, alert: t('bulletins.not_found')
    end

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

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

    def sign_in(user)
      session[:user_id] = user.id
    end

    def sign_out
      session.delete(:user_id)
      @current_user = nil
    end

    def user_not_authorized
      redirect_to root_path, alert: t('application.access_denied')
    end
  end
end
