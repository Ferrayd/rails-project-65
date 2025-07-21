# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < Web::Admin::ApplicationController
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
      end

      def publish
        bulletin = Bulletin.find(params[:id])

        return redirect_invalid_state unless bulletin.may_publish?

        perform_transition(bulletin, :publish, t('admin.bulletins.publish.success'))
      end

      def reject
        bulletin = Bulletin.find(params[:id])

        return redirect_invalid_state unless bulletin.may_reject?

        perform_transition(bulletin, :reject, t('admin.bulletins.reject.success'))
      end

      def archive
        bulletin = Bulletin.find(params[:id])

        return redirect_invalid_state unless bulletin.may_archive?

        perform_transition(bulletin, :archive, t('admin.bulletins.archive.success'))
      end

      private

      def perform_transition(bulletin, event, success_message)
        bulletin.public_send(event)

        if bulletin.save
          redirect_to admin_root_path, notice: success_message
        else
          redirect_to admin_root_path, alert: t('admin.bulletins.errors.save_failed')
        end
      end

      def redirect_invalid_state
        redirect_to admin_root_path, alert: t('admin.bulletins.errors.invalid_state')
      end
    end
  end
end
