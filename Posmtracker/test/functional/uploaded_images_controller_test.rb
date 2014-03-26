require 'test_helper'

class UploadedImagesControllerTest < ActionController::TestCase
  setup do
    @uploaded_image = uploaded_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:uploaded_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create uploaded_image" do
    assert_difference('UploadedImage.count') do
      post :create, uploaded_image: {  }
    end

    assert_redirected_to uploaded_image_path(assigns(:uploaded_image))
  end

  test "should show uploaded_image" do
    get :show, id: @uploaded_image
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @uploaded_image
    assert_response :success
  end

  test "should update uploaded_image" do
    put :update, id: @uploaded_image, uploaded_image: {  }
    assert_redirected_to uploaded_image_path(assigns(:uploaded_image))
  end

  test "should destroy uploaded_image" do
    assert_difference('UploadedImage.count', -1) do
      delete :destroy, id: @uploaded_image
    end

    assert_redirected_to uploaded_images_path
  end
end
