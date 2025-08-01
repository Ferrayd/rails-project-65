# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class CategoriesControllerPatchTest < ActionDispatch::IntegrationTest
      setup do
        @admin = users(:admin)
        @non_admin = users(:one)
        @category = categories(:one)
        @category_attrs = { name: Faker::Lorem.word.capitalize }
      end

      test 'admin should update category' do
        sign_in @admin
        patch admin_category_path(@category), params: { category: @category_attrs }
        assert_redirected_to admin_root_path
        assert_flash 'admin.categories.update.success'
        @category.reload
        assert_equal @category_attrs[:name], @category.name
      end

      test 'non-admin should not update category' do
        sign_in @non_admin
        original_name = @category.name
        patch admin_category_path(@category), params: { category: @category_attrs }
        assert_redirected_to root_path
        @category.reload
        assert_equal original_name, @category.name
      end

      test 'should not update category with invalid params' do
        sign_in @admin
        original_name = @category.name
        invalid_attrs = { name: '' }
        patch admin_category_path(@category), params: { category: invalid_attrs }
        assert_response :unprocessable_entity
        @category.reload
        assert_equal original_name, @category.name
      end
    end
  end
end
