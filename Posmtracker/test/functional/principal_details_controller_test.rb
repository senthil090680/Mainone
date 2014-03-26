require 'test_helper'

class PrincipalDetailsControllerTest < ActionController::TestCase
  setup do
    @principal_detail = principal_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:principal_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create principal_detail" do
    assert_difference('PrincipalDetail.count') do
      post :create, principal_detail: {  }
    end

    assert_redirected_to principal_detail_path(assigns(:principal_detail))
  end

  test "should show principal_detail" do
    get :show, id: @principal_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @principal_detail
    assert_response :success
  end

  test "should update principal_detail" do
    put :update, id: @principal_detail, principal_detail: {  }
    assert_redirected_to principal_detail_path(assigns(:principal_detail))
  end

  test "should destroy principal_detail" do
    assert_difference('PrincipalDetail.count', -1) do
      delete :destroy, id: @principal_detail
    end

    assert_redirected_to principal_details_path
  end
end
