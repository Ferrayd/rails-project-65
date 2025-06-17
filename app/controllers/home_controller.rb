class HomeController < ApplicationController
  def index
    @q = policy_scope(Bulletin).ransack(params[:q])
    @bulletins = @q.result.includes(:user, :category).page(params[:page]).per(10)
  end
  def about
  end
end
