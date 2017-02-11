require 'test_helper'

class AuthenticationControllerControllerTest < ActionController::TestCase
  test "should get signin_get" do
    get :signin_get
    assert_response :success
  end

  test "should get signup_get" do
    get :signup_get
    assert_response :success
  end

  test "should get signin" do
    get :signin
    assert_response :success
  end

  test "should get signup" do
    get :signup
    assert_response :success
  end

  test "should get logout" do
    get :logout
    assert_response :success
  end

end
