require "test_helper"

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get web_bulletins_index_url
    assert_response :success
  end

  test "should get new" do
    get web_bulletins_new_url
    assert_response :success
  end

  test "should get create" do
    get web_bulletins_create_url
    assert_response :success
  end
end
