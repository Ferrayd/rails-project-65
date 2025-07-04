# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < Web::Admin::BaseController
      def index
        @q = Bulletin.ransack(params[:q])
        @bulletins = @q.result.where(state: 'under_moderation').includes(:user, :category).page(params[:page]).per(10)
      end

      def all
        @q = Bulletin.ransack(params[:q])
        @bulletins = @q.result.includes(:user, :category).page(params[:page]).per(10)
        render :index
      end

      def show
        @bulletin = Bulletin.find(params[:id])
        authorize @bulletin
      end

      def publish
        bulletin = Bulletin.find(params[:id])
        authorize bulletin, :publish?
        bulletin.publish!
        redirect_to admin_root_path, notice: t('admin.bulletins.publish.success')
      end

      def reject
        bulletin = Bulletin.find(params[:id])
        authorize bulletin, :reject?
        bulletin.reject!
        redirect_to admin_root_path, notice: t('admin.bulletins.reject.success')
      end

      def archive
        bulletin = Bulletin.find(params[:id])
        authorize bulletin, :archive?
        bulletin.archive!
        redirect_to admin_root_path, notice: t('admin.bulletins.archive.success')
      end
    end
  end
end
