# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class CategoriesControllerDeleteTest < ActionDispatch::IntegrationTest
      setup do
        @admin = users(:admin)
        @non_admin = users(:one)
        @category = categories(:one)
      end

      test 'admin should destroy category' do
        sign_in @admin
        # Create a category without associated bulletins for deletion test
        deletable_category = Category.create!(name: 'Deletable Category')
        assert_difference('Category.count', -1) do
          delete admin_category_path(deletable_category)
        end
        assert_redirected_to admin_root_path
        assert_flash 'admin.categories.destroy.success'
      end

      test 'non-admin should not destroy category' do
        sign_in @non_admin
        assert_no_difference('Category.count') do
          delete admin_category_path(@category)
        end
        assert_redirected_to root_path
      end

      test 'should not destroy category with associated bulletins' do
        sign_in @admin
        # @category has associated bulletins, so it cannot be deleted
        assert_no_difference('Category.count') do
          delete admin_category_path(@category)
        end
        assert_response :unprocessable_entity
        assert_includes flash[:alert], 'Не удалось удалить категорию'
      end
    end
  end
end
