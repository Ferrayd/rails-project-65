# frozen_string_literal: true

module Web
  class BulletinsController < Web::ApplicationController
    def index
      @q = Bulletin.published.ransack(params[:q])
      @bulletins = @q.result.includes(:category, :user).order(created_at: :desc).page(params[:page]).per(9)
    end

    def show
      @bulletin = Bulletin.find(params[:id])
    end

    def new
      @bulletin = Bulletin.new
      authorize @bulletin
    end

    def edit
      @bulletin = current_user.bulletins.find(params[:id])
    end

    def create
      @bulletin = current_user.bulletins.build(bulletin_params)

      if @bulletin.save
        redirect_to root_path, notice: t('bulletins.create.success')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def to_moderation
      bulletin = current_user.bulletins.find(params[:id])
      authorize bulletin, :to_moderation?

      if bulletin.may_to_moderation?
        perform_moderation_transition(bulletin)
      else
        redirect_to profile_path, alert: t('bulletins.to_moderation.failure')
      end
    end

    def archive
      bulletin = current_user.bulletins.find(params[:id])

      return redirect_with_failure unless bulletin.may_archive?

      perform_archive_transition(bulletin)
    end

    def update
      @bulletin = current_user.bulletins.find(params[:id])

      if @bulletin.update(bulletin_params)
        redirect_to @bulletin, notice: t('bulletins.update.success')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def perform_moderation_transition(bulletin)
      bulletin.to_moderation
      if bulletin.save
        redirect_to profile_path, notice: t('bulletins.to_moderation.success')
      else
        redirect_to profile_path, alert: t('bulletins.save_error')
      end
    end

    def perform_archive_transition(bulletin)
      bulletin.archive
      if bulletin.save
        redirect_to profile_path, notice: t('bulletins.archive.success')
      else
        redirect_to profile_path, alert: t('bulletins.save_error')
      end
    end

    def redirect_with_failure
      redirect_to profile_path, alert: t('bulletins.archive.failure')
    end

    def redirect_to_root
      redirect_to root_path, alert: t('bulletins.not_found')
    end

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :image, :category_id)
    end
  end
end
