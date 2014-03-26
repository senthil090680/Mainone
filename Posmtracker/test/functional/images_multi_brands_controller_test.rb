require 'test_helper'

class ImagesMultiBrandsControllerTest < ActionController::TestCase
  setup do
    @images_multi_brand = images_multi_brands(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:images_multi_brands)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create images_multi_brand" do
    assert_difference('ImagesMultiBrand.count') do
      post :create, images_multi_brand: {  }
    end

    assert_redirected_to images_multi_brand_path(assigns(:images_multi_brand))
  end

  test "should show images_multi_brand" do
    get :show, id: @images_multi_brand
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @images_multi_brand
    assert_response :success
  end

  test "should update images_multi_brand" do
    put :update, id: @images_multi_brand, images_multi_brand: {  }
    assert_redirected_to images_multi_brand_path(assigns(:images_multi_brand))
  end

  test "should destroy images_multi_brand" do
    assert_difference('ImagesMultiBrand.count', -1) do
      delete :destroy, id: @images_multi_brand
    end

    assert_redirected_to images_multi_brands_path
  end
end
