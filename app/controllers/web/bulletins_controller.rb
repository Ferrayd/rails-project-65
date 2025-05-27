class Web::BulletinsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]

  def index
    @bulletins = Bulletin.order(created_at: :desc).includes(:category, :user)
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

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :image, :category_id)
  end
end
