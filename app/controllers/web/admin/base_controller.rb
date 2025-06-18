# frozen_string_literal: true

module Web
  module Admin
    class BaseController < Web::ApplicationController
      before_action :authorize_admin!

      private

      def authorize_admin!
        authorize %i[admin base], :access?
      end
    end
  end
end
