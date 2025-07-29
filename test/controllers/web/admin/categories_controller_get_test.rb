# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class CategoriesControllerGetTest < ActionDispatch::IntegrationTest
      setup do
        @admin = users(:admin)
        @non_admin = users(:one)
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

      test 'admin should get index' do
        sign_in @admin
        get admin_categories_path
        assert_response :success
      end

      test 'non-admin should be redirected from index' do
        sign_in @non_admin
        get admin_categories_path
        assert_redirected_to root_path
      end

      test 'admin should get edit' do
        sign_in @admin
        get edit_admin_category_path(@category)
        assert_response :success
      end

      test 'non-admin should be redirected from edit' do
        sign_in @non_admin
        get edit_admin_category_path(@category)
        assert_redirected_to root_path
      end
    end
  end
end
