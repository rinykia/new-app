require 'test_helper'

class AdministratorsControllerTest < ActionController::TestCase
  test "should get dasboard" do
    get :dasboard
    assert_response :success
  end

end
