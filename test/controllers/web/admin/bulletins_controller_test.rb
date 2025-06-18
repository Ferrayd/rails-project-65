# frozen_string_literal: true

require 'test_helper'

FIXTURE_IMAGE_FILE_NAME = 'bulletin_4.jpg'

module Web
  module Admin
    class BulletinsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user_admin = users(:admin)
        @user = users(:one)
        @bulletin = bulletins(:under_moderation)
      end

      test 'should create bulletin' do
        sign_in @user
        image = fixture_file_upload(Rails.root.join('test/fixtures/files/bulletin_4.jpg'))
        attrs = {
          title: 'Test title',
          description: 'Test description',
          category_id: categories(:two).id,
          image: image
        }

        assert_difference('Bulletin.count', 1) do
          post bulletins_path, params: { bulletin: attrs }
        end

        created_bulletin = Bulletin.find_by(
          title: attrs[:title],
          description: attrs[:description],
          category_id: attrs[:category_id],
          user_id: @user.id
        )

        assert created_bulletin, 'Bulletin was not created with correct attributes'
        assert_equal @user, created_bulletin.user, 'Bulletin does not belong to the correct user'
        assert_equal categories(:two), created_bulletin.category, 'Incorrect category associated'
        assert_equal image.original_filename, created_bulletin.image.filename.to_s, 'Image was not saved correctly'

        assert_redirected_to root_path
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
