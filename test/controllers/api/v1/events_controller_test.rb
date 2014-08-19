require 'test_helper'

class Api::V1::EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
    @request.headers['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(Settings.api.login, Settings.api.password)
  end

  test "should get index" do
    xhr :get, :index, @authentication
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should create event" do
    assert_difference('Event.count') do
      event_hash = {
        name: @event.name,
        first_at: @event.first_at,
        last_at: @event.last_at,
        wday: @event.wday,
        s_hr: @event.s_hr,
        s_min: @event.s_min,
        e_hr: @event.e_hr,
        e_min: @event.e_min,
        created_at: @event.created_at,
        updated_at: @event.updated_at
      }
      xhr :post, :create, event: event_hash
    end

    assert_response :success
  end

  test "should show event" do
    xhr :get, :show, id: @event
    assert_response :success
  end

  test "should update event" do
    event_hash = {
      name: @event.name,
      first_at: @event.first_at,
      last_at: @event.last_at,
      wday: @event.wday,
      s_hr: @event.s_hr,
      s_min: @event.s_min,
      e_hr: @event.e_hr,
      e_min: @event.e_min,
      created_at: @event.created_at,
      updated_at: @event.updated_at
    }
    xhr :patch, :update, id: @event, event: event_hash

    assert_response :success
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      xhr :delete, :destroy, id: @event
    end

    assert_response :success
  end
end
