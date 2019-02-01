require 'test_helper'

module Admin
  class TopControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index" do
      get top_index_url
      assert_response :success
    end

  end
end
