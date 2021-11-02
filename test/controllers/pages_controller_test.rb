require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Home | Forecastly Weather Application"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | Forecastly Weather Application"
  end

  test "should get signup page" do
    get signup_path
    assert_response :success
    assert_select "title", "Signup | Forecastly Weather Application"
  end 
end
