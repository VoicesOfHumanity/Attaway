require 'test_helper'

class StarsControllerTest < ActionController::TestCase
  setup do
    @star = stars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create star" do
    assert_difference('Star.count') do
      post :create, :star => @star.attributes
    end

    assert_redirected_to star_path(assigns(:star))
  end

  test "should show star" do
    get :show, :id => @star.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @star.to_param
    assert_response :success
  end

  test "should update star" do
    put :update, :id => @star.to_param, :star => @star.attributes
    assert_redirected_to star_path(assigns(:star))
  end

  test "should destroy star" do
    assert_difference('Star.count', -1) do
      delete :destroy, :id => @star.to_param
    end

    assert_redirected_to stars_path
  end
end
