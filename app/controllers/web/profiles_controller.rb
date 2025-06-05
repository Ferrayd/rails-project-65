module Web
  class ProfilesController < ApplicationController
    before_action :authenticate_user!

    def show
      @bulletins = current_user.bulletins.order(created_at: :desc)
    end
  end
end
