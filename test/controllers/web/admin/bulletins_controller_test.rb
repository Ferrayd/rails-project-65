# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class BulletinsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user_admin = users(:admin)
        @bulletin = bulletins(:under_moderation)
      end

      test 'non-admins should be redirected from index' do
        get admin_bulletins_path
        assert_redirected_to root_path

        sign_in users(:one)
        get admin_bulletins_path
        assert_redirected_to root_path
      end

      test 'admin should get index' do
        sign_in @user_admin
        get admin_bulletins_path
        assert_response :success
      end

      test 'admin should get all bulletins' do
        sign_in @user_admin
        get all_admin_bulletins_path
        assert_response :success
      end

      test 'non-admin should be redirected from all bulletins' do
        get all_admin_bulletins_path
        assert_redirected_to root_path

        sign_in users(:one)
        get all_admin_bulletins_path
        assert_redirected_to root_path
      end

      test 'admin should archive bulletin' do
        sign_in @user_admin
        patch archive_admin_bulletin_path(@bulletin)
        assert_redirected_to admin_root_path
        assert_equal I18n.t('admin.bulletins.archive.success'), flash[:notice]
        assert @bulletin.reload.archived?, 'Bulletin was not archived'
      end

      test 'admin should succeed in publishing bulletin' do
        sign_in @user_admin
        patch publish_admin_bulletin_path(@bulletin)
        assert_redirected_to admin_root_path
        assert_equal I18n.t('admin.bulletins.publish.success'), flash[:notice]
        assert @bulletin.reload.published?, 'Bulletin was not published'
      end

      test 'admin should reject bulletin' do
        sign_in @user_admin
        patch reject_admin_bulletin_path(@bulletin)
        assert_redirected_to admin_root_path
        assert_equal I18n.t('admin.bulletins.reject.success'), flash[:notice]
        assert @bulletin.reload.rejected?, 'Bulletin was not rejected'
      end
    end
  end
end
