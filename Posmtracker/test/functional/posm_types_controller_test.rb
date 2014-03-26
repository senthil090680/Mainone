require 'test_helper'

class PosmTypesControllerTest < ActionController::TestCase
  setup do
    @posm_type = posm_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posm_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create posm_type" do
    assert_difference('PosmType.count') do
      post :create, posm_type: {  }
    end

    assert_redirected_to posm_type_path(assigns(:posm_type))
  end

  test "should show posm_type" do
    get :show, id: @posm_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @posm_type
    assert_response :success
  end

  test "should update posm_type" do
    put :update, id: @posm_type, posm_type: {  }
    assert_redirected_to posm_type_path(assigns(:posm_type))
  end

  test "should destroy posm_type" do
    assert_difference('PosmType.count', -1) do
      delete :destroy, id: @posm_type
    end

    assert_redirected_to posm_types_path
  end
end
