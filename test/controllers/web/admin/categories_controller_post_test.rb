# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class CategoriesControllerPostTest < ActionDispatch::IntegrationTest
      setup do
        @admin = users(:admin)
        @non_admin = users(:one)
        @category_attrs = { name: 'Новая категория' }
      end

      test 'admin should create category' do
        sign_in @admin
        assert_difference('Category.count', 1) do
          post admin_categories_path, params: { category: @category_attrs }
        end
        created_category = Category.find_by(@category_attrs)
        assert_redirected_to admin_root_path
        assert_flash 'admin.categories.create.success'
        assert { created_category }
      end

      test 'non-admin should not create category' do
        sign_in @non_admin
        assert_no_difference('Category.count') do
          post admin_categories_path, params: { category: @category_attrs }
        end
        assert_redirected_to root_path
      end

      test 'should not create category with invalid params' do
        sign_in @admin
        invalid_attrs = { name: '' }
        assert_no_difference('Category.count') do
          post admin_categories_path, params: { category: invalid_attrs }
        end
        assert_response :unprocessable_entity
      end
    end
  end
end
