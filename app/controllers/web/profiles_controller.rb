module Web
  class ProfilesController < Web::ApplicationController
    before_action :authenticate_user!

  def show
    @q = current_user.bulletins.ransack(params[:q])
    @bulletins = @q.result.includes(:category, :user).order(created_at: :desc).page(params[:page]).per(10)
  end

    private

    def authenticate_user!
      redirect_to root_path, alert: t("profiles.authenticate.alert") unless current_user
    end
  end
end
