# frozen_string_literal: true

require "test_helper"

FIXTURE_IMAGE_FILE_NAME = "bulletin_4.jpg"

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
      sign_in @user
    end

    test "should get root" do
      get root_path
      assert_response :success
    end

    test "should get index" do
      get bulletins_path
      assert_response :success
    end

    test "should get new" do
      get new_bulletin_path
      assert_response :success
    end

    test "should create bulletin" do
      image = fixture_file_upload(FIXTURE_IMAGE_FILE_NAME)
      post bulletins_path, params: { bulletin: { **@archived_attrs, image: image } }
      created_bulletin = Bulletin.last
      assert_redirected_to root_path
      assert_equal I18n.t("bulletins.create.success"), flash[:notice]
      assert { @archived_attrs.all? { |key, value| created_bulletin[key] == value } }
      assert_equal image.original_filename, created_bulletin.image.filename.to_s
    end

    test "should show bulletin" do
      get bulletin_path(@bulletin)
      assert_response :success
    end

    test "should archive bulletin" do
      patch archive_bulletin_path(@bulletin)
      assert_redirected_to profile_path
      assert_equal I18n.t("bulletins.archive.success"), flash[:notice]
      assert { @bulletin.reload.archived? }
    end

    test "should to_moderation bulletin" do
      patch to_moderation_bulletin_path(@bulletin)
      assert_redirected_to profile_path
      assert_equal I18n.t("bulletins.to_moderation.success"), flash[:notice]
      assert { @bulletin.reload.under_moderation? }
    end
  end
end
