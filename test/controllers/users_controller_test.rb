require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:eslam)
    @other_user = users(:test)
  end

  test "should get index" do
    log_in_as(@user)
    get users_path
    assert_response :success
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_path
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    get signup_path
    assert_difference('User.count') do
      post users_url, params: { user: {name: "test", email: "test@example.com", password: "password123", password_confirmation: "password123", country: "PL"} }
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@user)
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    log_in_as(@user)
    patch user_url(@user), params: { user: { admin: @user.admin, email: @user.email, name: @user.name, password_digest: @user.password_digest } }
    assert_redirected_to root_path
  end

  test "should destroy user" do
    log_in_as(@user)
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end
    assert_redirected_to login_path
  end

  test "should destroy not allowed to delete another user" do
    log_in_as(@user)
    assert_no_difference('User.count') do
      delete user_url(@other_user)
    end
    assert_redirected_to root_path
  end
end
