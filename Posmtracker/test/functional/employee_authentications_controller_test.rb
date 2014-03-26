require 'test_helper'

class EmployeeAuthenticationsControllerTest < ActionController::TestCase
  setup do
    @employee_authentication = employee_authentications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:employee_authentications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create employee_authentication" do
    assert_difference('EmployeeAuthentication.count') do
      post :create, employee_authentication: {  }
    end

    assert_redirected_to employee_authentication_path(assigns(:employee_authentication))
  end

  test "should show employee_authentication" do
    get :show, id: @employee_authentication
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @employee_authentication
    assert_response :success
  end

  test "should update employee_authentication" do
    put :update, id: @employee_authentication, employee_authentication: {  }
    assert_redirected_to employee_authentication_path(assigns(:employee_authentication))
  end

  test "should destroy employee_authentication" do
    assert_difference('EmployeeAuthentication.count', -1) do
      delete :destroy, id: @employee_authentication
    end

    assert_redirected_to employee_authentications_path
  end
end
