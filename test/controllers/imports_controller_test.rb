require "test_helper"

class ImportsControllerTest < ActionDispatch::IntegrationTest
  test "should get create_pdf" do
    get imports_create_pdf_url
    assert_response :success
  end
end
