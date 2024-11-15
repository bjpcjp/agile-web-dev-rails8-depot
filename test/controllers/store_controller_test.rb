require "test_helper"

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success
    assert_select "nav a",      minimum: 4 # 4 links
    assert_select "main ul li", 3          # product fixtures = 3 items
    assert_select "h1",         "Catalog"  #
    #assert_select "div",        /\$[,\d]+\.\dd/ # verifies correct pricing format
  end
end
