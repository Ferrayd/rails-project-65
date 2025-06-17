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
        redirect_to root_path, notice: t("bulletins.create.success")
      else
        render :new, status: :unprocessable_entity
      end
    end

    def to_moderation
      bulletin = current_user.bulletins.find(params[:id])
      authorize bulletin, :to_moderation?

      bulletin.to_moderation!
      redirect_to profile_path, notice: t("bulletins.to_moderation.success")
    end

    def archive
      bulletin = current_user.bulletins.find(params[:id])
      authorize bulletin, :archive?

      bulletin.archive!
      redirect_to profile_path, notice: t("bulletins.archive.success")
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :image, :category_id)
    end
  end
end
