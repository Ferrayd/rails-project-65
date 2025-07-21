# frozen_string_literal: true

module Web
  module Admin
    class ApplicationController < Web::ApplicationController
      before_action :authorize_admin!

      private

      def authorize_admin!
        return if current_user&.admin?

        redirect_to root_path, alert: t('web.admin.errors.not_authorized')
      end
    end
  end
end
