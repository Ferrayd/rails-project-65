module Web
  module Admin
    class BulletinsController < BaseController
      def index
        @bulletins = Bulletin.where(state: :under_moderation)
      end

      def show
        @bulletin = Bulletin.find(params[:id])
      end

      def publish
        bulletin = Bulletin.find(params[:id])
        bulletin.publish!
        redirect_to web_admin_bulletins_path, notice: "Объявление опубликовано"
      end

      def reject
        bulletin = Bulletin.find(params[:id])
        bulletin.reject!
        redirect_to web_admin_bulletins_path, notice: "Объявление отклонено"
      end

      def archive
        bulletin = Bulletin.find(params[:id])
        bulletin.archive!
        redirect_to web_admin_bulletins_path, notice: "Объявление архивировано"
      end
    end
  end
end
