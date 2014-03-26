require 'test_helper'

class BrandDetailsControllerTest < ActionController::TestCase
  setup do
    @brand_detail = brand_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:brand_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create brand_detail" do
    assert_difference('BrandDetail.count') do
      post :create, brand_detail: {  }
    end

    assert_redirected_to brand_detail_path(assigns(:brand_detail))
  end

  test "should show brand_detail" do
    get :show, id: @brand_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @brand_detail
    assert_response :success
  end

  test "should update brand_detail" do
    put :update, id: @brand_detail, brand_detail: {  }
    assert_redirected_to brand_detail_path(assigns(:brand_detail))
  end

  test "should destroy brand_detail" do
    assert_difference('BrandDetail.count', -1) do
      delete :destroy, id: @brand_detail
    end

    assert_redirected_to brand_details_path
  end
end
