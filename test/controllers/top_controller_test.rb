require 'test_helper'

class TopControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get top_show_url
    assert_response :success
  end

end
