# frozen_string_literal: true

module Web
  module Admin
    class CategoriesController < Web::Admin::ApplicationController
      def index
        @categories = Category.all
      end

      def new
        @category = Category.new
      end

      def edit
        @category = Category.find(params[:id])
      end

      def create
        @category = Category.new(category_params)

        if @category.save
          redirect_to admin_root_path, notice: t('admin.categories.create.success')
        else
          render :new, status: :unprocessable_entity
        end
      end

      def update
        @category = Category.find(params[:id])

        if @category.update(category_params)
          redirect_to admin_root_path, notice: t('admin.categories.update.success')
        else
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        @category = Category.find(params[:id])

        if @category.destroy
          redirect_to admin_root_path, notice: t('admin.categories.destroy.success')
        else
          flash.now[:alert] = t('admin.categories.destroy.error')
          @categories = Category.all
          render :index, status: :unprocessable_entity
        end
      end

      private

      def category_params
        params.require(:category).permit(:name)
      end
    end
  end
end
