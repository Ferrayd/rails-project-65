class Web::BulletinsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]

  def index
    @bulletins = Bulletin.published.order(created_at: :desc).includes(:category, :user)
  end

  def new
    @bulletin = Bulletin.new
  end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)

    if @bulletin.save
      redirect_to web_root_path, notice: "Объявление создано"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def to_moderation
    bulletin = current_user.bulletins.find(params[:id])
    authorize bulletin, :update?

    bulletin.to_moderation!
    redirect_to profile_path, notice: "Объявление отправлено на модерацию"
  end

  def archive
    bulletin = current_user.bulletins.find(params[:id])
    authorize bulletin, :update?

    bulletin.archive!
    redirect_to profile_path, notice: "Объявление архивировано"
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :image, :category_id)
  end
end
