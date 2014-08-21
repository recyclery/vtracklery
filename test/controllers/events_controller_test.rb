require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    event_hash = {
      e_hr: @event.e_hr,
      e_min: @event.e_min,
      first_at: @event.first_at,
      last_at: @event.last_at,
      name: @event.name,
      s_hr: @event.s_hr,
      s_min: @event.s_min,
      wday: @event.wday
    }
    assert_difference('Event.count') do
      post :create, event: event_hash
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "should show event" do
    get :show, id: @event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event
    assert_response :success
  end

  test "should update event" do
    event_hash = {
      e_hr: @event.e_hr,
      e_min: @event.e_min,
      first_at: @event.first_at,
      last_at: @event.last_at,
      name: @event.name,
      s_hr: @event.s_hr,
      s_min: @event.s_min,
      wday: @event.wday
    }
    patch :update, id: @event, event: event_hash
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_redirected_to events_path
  end
end
