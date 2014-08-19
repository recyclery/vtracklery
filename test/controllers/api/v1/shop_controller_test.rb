require 'test_helper'

class Api::V1::ShopsControllerTest < ActionController::TestCase
  setup do
    @shop = shop(:one)
    @request.headers['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(Settings.api.login, Settings.api.password)
  end

  test "should get index" do
    xhr :get, :index, @authentication
    assert_response :success
    assert_not_nil assigns(:shop)
  end

  test "should create shop" do
    assert_difference('Shop.count') do
      shop_hash = {

      }
      xhr :post, :create, shop: shop_hash
    end

    assert_response :success
  end

  test "should show shop" do
    xhr :get, :show, id: @shop
    assert_response :success
  end

  test "should update shop" do
    shop_hash = {

    }
    xhr :patch, :update, id: @shop, shop: shop_hash

    assert_response :success
  end

  test "should destroy shop" do
    assert_difference('Shop.count', -1) do
      xhr :delete, :destroy, id: @shop
    end

    assert_response :success
  end
end
