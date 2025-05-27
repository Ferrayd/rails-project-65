module Web
  module Admin
    class CategoriesController < BaseController
      def index
        @categories = Category.all
      end

      def new
        @category = Category.new
      end

      def create
        @category = Category.new(category_params)
        if @category.save
          redirect_to web_admin_categories_path, notice: "Категория создана"
        else
          render :new
        end
      end

      def edit
        @category = Category.find(params[:id])
      end

      def update
        @category = Category.find(params[:id])
        if @category.update(category_params)
          redirect_to web_admin_categories_path, notice: "Категория обновлена"
        else
          render :edit
        end
      end

      def destroy
        @category = Category.find(params[:id])
        @category.destroy
        redirect_to web_admin_categories_path, notice: "Категория удалена"
      end

      private

      def category_params
        params.require(:category).permit(:name)
      end
    end
  end
end
