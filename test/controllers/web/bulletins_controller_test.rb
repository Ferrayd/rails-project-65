# frozen_string_literal: true

require 'test_helper'

FIXTURE_IMAGE_FILE_NAME = 'bulletin_4.jpg'

module Web
  class BulletinsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @bulletin = bulletins(:draft)
      @archived_attrs = {
        title: bulletins(:archived).title,
        description: bulletins(:archived).description,
        category_id: categories(:two).id
      }
      @user = users(:system_test)
      @other_user = users(:one)
      sign_in @user
    end

    test 'should get root' do
      get root_path
      assert_response :success
    end

    test 'should get index' do
      get bulletins_path
      assert_response :success
    end

    test 'should get new' do
      get new_bulletin_path
      assert_response :success
    end

    test 'should create bulletin' do
      image = fixture_file_upload(FIXTURE_IMAGE_FILE_NAME)
      post bulletins_path, params: { bulletin: { **@archived_attrs, image: image } }
      created_bulletin = Bulletin.last
      assert_redirected_to root_path
      assert_equal I18n.t('bulletins.create.success'), flash[:notice]
      assert { @archived_attrs.all? { |key, value| created_bulletin[key] == value } }
      assert_equal image.original_filename, created_bulletin.image.filename.to_s
    end

    test 'should not create bulletin with invalid params' do
      invalid_attrs = { title: '', description: '', category_id: nil }
      assert_no_difference('Bulletin.count') do
        post bulletins_path, params: { bulletin: invalid_attrs }
      end
      assert_response :unprocessable_entity
    end

    test 'should show bulletin' do
      get bulletin_path(@bulletin)
      assert_response :success
    end

    test 'should get edit' do
      get edit_bulletin_path(@bulletin)
      assert_response :success
      assert_equal @bulletin, assigns(:bulletin), 'Correct bulletin was not assigned'
    end

    test 'should not get edit for unauthorized user' do
      sign_in @other_user
      get edit_bulletin_path(@bulletin)
      assert_redirected_to root_path
    end

    test 'should update bulletin' do
      new_attrs = {
        title: 'Updated Title',
        description: 'Updated Description',
        category_id: categories(:one).id
      }
      patch bulletin_path(@bulletin), params: { bulletin: new_attrs }
      assert_redirected_to bulletin_path(@bulletin)
      assert_equal I18n.t('bulletins.update.success'), flash[:notice]
      @bulletin.reload
      assert { new_attrs.all? { |key, value| @bulletin[key] == value } }
    end

    test 'should not update bulletin with invalid params' do
      invalid_attrs = { title: '', description: '', category_id: nil }
      patch bulletin_path(@bulletin), params: { bulletin: invalid_attrs }
      assert_response :unprocessable_entity
    end

    test 'should not update bulletin for unauthorized user' do
      sign_in @other_user
      patch bulletin_path(@bulletin), params: { bulletin: @archived_attrs }
      assert_redirected_to root_path
    end

    test 'should archive bulletin' do
      patch archive_bulletin_path(@bulletin)
      assert_redirected_to profile_path
      assert_equal I18n.t('bulletins.archive.success'), flash[:notice]
      assert { @bulletin.reload.archived? }
    end

    test 'should not archive bulletin for unauthorized user' do
      sign_in @other_user
      patch archive_bulletin_path(@bulletin)
      assert_redirected_to root_path
    end

    test 'should to_moderation bulletin' do
      patch to_moderation_bulletin_path(@bulletin)
      assert_redirected_to profile_path
      assert_equal I18n.t('bulletins.to_moderation.success'), flash[:notice]
      assert { @bulletin.reload.under_moderation? }
    end

    test 'should not to_moderation bulletin for unauthorized user' do
      sign_in @other_user
      patch to_moderation_bulletin_path(@bulletin)
      assert_redirected_to root_path
    end
  end
end
