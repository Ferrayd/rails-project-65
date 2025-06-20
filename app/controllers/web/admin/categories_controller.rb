# frozen_string_literal: true

module Web
  module Admin
    class CategoriesController < Web::Admin::BaseController
      def index
        @categories = Category.all
        authorize Category
      end

      def new
        @category = Category.new
        authorize @category
      end

      def edit
        @category = Category.find(params[:id])
        authorize @category
      end

      def create
        @category = Category.new(category_params)
        authorize @category

        if @category.save
          redirect_to admin_root_path, notice: t('admin.categories.create.success')
        else
          render :new, status: :unprocessable_entity
        end
      end

      def update
        @category = Category.find(params[:id])
        authorize @category

        if @category.update(category_params)
          redirect_to admin_root_path, notice: t('admin.categories.update.success')
        else
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        @category = Category.find(params[:id])
        authorize @category
        @category.destroy
        redirect_to admin_root_path, notice: t('admin.categories.destroy.success')
      end

      private

      def category_params
        params.require(:category).permit(:name)
      end
    end
  end
end
