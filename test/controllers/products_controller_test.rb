require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get products_create_url
    assert_response :success
  end
end
