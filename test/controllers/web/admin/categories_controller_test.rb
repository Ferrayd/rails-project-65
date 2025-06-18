# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class CategoriesControllerTest < ActionDispatch::IntegrationTest
      setup do
        @admin = users(:admin)
        @non_admin = users(:one)
        @category_attrs = { name: 'Новая категория' }
        @category = categories(:one)
      end

      test 'admin should get new' do
        sign_in @admin
        get new_admin_category_path
        assert_response :success
      end

      test 'non-admin should be redirected from new' do
        sign_in @non_admin
        get new_admin_category_path
        assert_redirected_to root_path
      end

      test 'admin should create category' do
        sign_in @admin
        assert_difference('Category.count', 1) do
          post admin_categories_path, params: { category: @category_attrs }
        end
        assert_redirected_to admin_root_path
        assert_flash 'admin.categories.create.success'
      end

      test 'non-admin should not create category' do
        sign_in @non_admin
        assert_no_difference('Category.count') do
          post admin_categories_path, params: { category: @category_attrs }
        end
        assert_redirected_to root_path
      end
    end
  end
end
