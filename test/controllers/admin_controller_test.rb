require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get users" do
    get :users
    assert_response :success
  end

  test "should get revoke_admin" do
    get :revoke_admin
    assert_response :success
  end

  test "should get grant_admin" do
    get :grant_admin
    assert_response :success
  end

end
