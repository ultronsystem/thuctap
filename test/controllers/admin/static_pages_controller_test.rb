require 'test_helper'

class Admin::StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get admin_static_pages_home_url
    assert_response :success
  end

end
