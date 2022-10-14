require "test_helper"

class Businesses::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get businesses_dashboard_index_url
    assert_response :success
  end
end
