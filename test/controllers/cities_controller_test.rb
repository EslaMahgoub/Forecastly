require "test_helper"

class CitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @city = cities(:one)
    @user = users(:eslam)
    @other_user = users(:test)
  end

  test "should add city" do
    name = "Cairo"
    # Valid submission
    log_in_as(@user)
    assert_difference 'City.count', 1 do
      post cities_path, params: { city: { name: name } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match name, response.body
  end

  test "should add city ajax" do
    name = "Cairo"
    log_in_as(@user)
    assert_difference('City.count') do
      post cities_url, xhr: true, params: { city: { name: name } }
    end
    assert_match name, response.body
  end

  test "should not add city with invalid submission" do
    log_in_as(@user)
    assert_no_difference 'City.count' do
      post cities_path, params: { city: { name: "" } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_select 'div.alert'
  end

  test "should not add city with invalid submission with ajax" do
    log_in_as(@user)
    assert_no_difference 'City.count', 1 do
      post cities_path, xhr: true, params: { city: { name: "" } }
    end
  end

  test "should remove city subscription from user" do 
    log_in_as(@user)
    @city.users << @user
    assert_difference('@city.users.count', -1) do
      delete city_url(@city)
    end
    assert_redirected_to root_url
  end

  test "should keep city subscription for other users" do 
    log_in_as(@user)
    @city.users << @user
    @city.users << @other_user
    assert_no_difference('@other_user.cities.count') do
      delete city_url(@city)
    end
    assert_redirected_to root_url
  end
end
