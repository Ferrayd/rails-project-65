# frozen_string_literal: true

module Web
  class ProfilesController < Web::ApplicationController
    before_action :authenticate_user!

    def show
      @q = current_user.bulletins.ransack(params[:q])
      @bulletins = @q.result.includes(:category).order(created_at: :desc).page(params[:page]).per(10)
    end
  end
end
