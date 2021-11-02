require "test_helper"

class UserProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:eslam)
  end


  test "profile page" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    #assert_select 'h1>img.gravatar'
    #assert_match @user.snapshots.count.to_s, response.body
    #TODO: Test Pagiantion
    
  end
  
end
