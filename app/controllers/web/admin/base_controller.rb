module Web
  module Admin
    class BaseController < Web::ApplicationController
      before_action :authorize_admin!

      private

      def authorize_admin!
        authorize [ :admin, :base ], :access?
      end
    end
  end
end
