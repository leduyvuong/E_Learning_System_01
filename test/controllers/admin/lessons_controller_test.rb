require "test_helper"

class Admin::LessonsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_lessons_new_url
    assert_response :success
  end
end
