# frozen_string_literal: true

module Web
  class BulletinsController < Web::ApplicationController
    def index
      @q = Bulletin.published.ransack(params[:q])
      @bulletins = @q.result.includes(:category, :user).order(created_at: :desc).page(params[:page]).per(9)
    end

    def show
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
    end

    def new
      @bulletin = Bulletin.new
      authorize @bulletin
    end

    def create
      @bulletin = current_user.bulletins.build(bulletin_params)
      authorize @bulletin

      if @bulletin.save
        redirect_to root_path, notice: t('bulletins.create.success')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def to_moderation
      bulletin = current_user.bulletins.find_by(id: params[:id])
      if bulletin
        authorize bulletin, :to_moderation?
        bulletin.to_moderation!
        redirect_to profile_path, notice: t('bulletins.to_moderation.success')
      else
        redirect_to root_path, alert: t('bulletins.not_found')
      end
    end

    def archive
      bulletin = current_user.bulletins.find_by(id: params[:id])
      if bulletin
        authorize bulletin, :archive?
        bulletin.archive!
        redirect_to profile_path, notice: t('bulletins.archive.success')
      else
        redirect_to root_path, alert: t('bulletins.not_found')
      end
    end

    def edit
      @bulletin = current_user.bulletins.find_by(id: params[:id])
      if @bulletin
        authorize @bulletin
      else
        redirect_to root_path, alert: t('bulletins.not_found')
      end
    end

    def update
      @bulletin = current_user.bulletins.find_by(id: params[:id])
      if @bulletin
        authorize @bulletin
        if @bulletin.update(bulletin_params)
          redirect_to @bulletin, notice: t('bulletins.update.success')
        else
          render :edit, status: :unprocessable_entity
        end
      else
        redirect_to root_path, alert: t('bulletins.not_found')
      end
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :image, :category_id)
    end
  end
end
