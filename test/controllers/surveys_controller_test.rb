require 'test_helper'

class SurveysControllerTest < ActionController::TestCase
  setup do
    @survey = surveys(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:surveys)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create survey" do
    survey_hash = {
      assist_host: @survey.assist_host,
      assist_overhaul: @survey.assist_overhaul,
      assist_tuneup: @survey.assist_tuneup,
      assist_youth: @survey.assist_youth,
      can_adjust_bearing: @survey.can_adjust_bearing,
      can_adjust_brakes: @survey.can_adjust_brakes,
      can_adjust_derailleurs: @survey.can_adjust_derailleurs,
      can_fix_flat: @survey.can_fix_flat,
      can_name_bike: @survey.can_name_bike,
      can_overhaul_bracket: @survey.can_overhaul_bracket,
      can_overhaul_headset: @survey.can_overhaul_headset,
      can_overhaul_hubs: @survey.can_overhaul_hubs,
      can_remove_pedals: @survey.can_remove_pedals,
      can_replace_brakes: @survey.can_replace_brakes,
      can_replace_cables: @survey.can_replace_cables,
      can_replace_fork: @survey.can_replace_fork,
      can_replace_seat: @survey.can_replace_seat,
      can_replace_shifters: @survey.can_replace_shifters,
      can_replace_tire: @survey.can_replace_tire,
      can_true_wheels: @survey.can_true_wheels,
      comment: @survey.comment,
      drive_stick: @survey.drive_stick,
      frequency: @survey.frequency,
      fri_vol: @survey.fri_vol,
      greet_open: @survey.greet_open,
      have_vehicle: @survey.have_vehicle,
      host_program: @survey.host_program,
      organize_drive: @survey.organize_drive,
      organize_events: @survey.organize_events,
      pickup_donations: @survey.pickup_donations,
      replace_crank: @survey.replace_crank,
      represent_recyclery: @survey.represent_recyclery,
      sat_open: @survey.sat_open,
      sat_sale: @survey.sat_sale,
      sell_ebay: @survey.sell_ebay,
      skill_carpentry: @survey.skill_carpentry,
      skill_coordination: @survey.skill_coordination,
      skill_drawing: @survey.skill_drawing,
      skill_fundraising: @survey.skill_fundraising,
      skill_grants: @survey.skill_grants,
      skill_graphic_design: @survey.skill_graphic_design,
      skill_newsletter: @survey.skill_newsletter,
      skill_photography: @survey.skill_photography,
      skill_programming: @survey.skill_programming,
      skill_videography: @survey.skill_videography,
      taken_overhaul: @survey.taken_overhaul,
      taken_tuneup: @survey.taken_tuneup,
      thurs_open: @survey.thurs_open,
      thurs_youth: @survey.thurs_youth,
      tues_open: @survey.tues_open,
      tues_vol: @survey.tues_vol,
      worker_id: @survey.worker_id
    }

    assert_difference('Survey.count') do
      post :create, survey: survey_hash
    end

    #assert_redirected_to worker_path(assigns(:worker))
    assert_redirected_to worker_path(@survey.worker_id)
  end

  test "should show survey" do
    get :show, id: @survey
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @survey
    assert_response :success
  end

  test "should update survey" do
    survey_hash = {
      assist_host: @survey.assist_host,
      assist_overhaul: @survey.assist_overhaul,
      assist_tuneup: @survey.assist_tuneup,
      assist_youth: @survey.assist_youth,
      can_adjust_bearing: @survey.can_adjust_bearing,
      can_adjust_brakes: @survey.can_adjust_brakes,
      can_adjust_derailleurs: @survey.can_adjust_derailleurs,
      can_fix_flat: @survey.can_fix_flat,
      can_name_bike: @survey.can_name_bike,
      can_overhaul_bracket: @survey.can_overhaul_bracket,
      can_overhaul_headset: @survey.can_overhaul_headset,
      can_overhaul_hubs: @survey.can_overhaul_hubs,
      can_remove_pedals: @survey.can_remove_pedals,
      can_replace_brakes: @survey.can_replace_brakes,
      can_replace_cables: @survey.can_replace_cables,
      can_replace_fork: @survey.can_replace_fork,
      can_replace_seat: @survey.can_replace_seat,
      can_replace_shifters: @survey.can_replace_shifters,
      can_replace_tire: @survey.can_replace_tire,
      can_true_wheels: @survey.can_true_wheels,
      comment: @survey.comment,
      drive_stick: @survey.drive_stick,
      frequency: @survey.frequency,
      fri_vol: @survey.fri_vol,
      greet_open: @survey.greet_open,
      have_vehicle: @survey.have_vehicle,
      host_program: @survey.host_program,
      organize_drive: @survey.organize_drive,
      organize_events: @survey.organize_events,
      pickup_donations: @survey.pickup_donations,
      replace_crank: @survey.replace_crank,
      represent_recyclery: @survey.represent_recyclery,
      sat_open: @survey.sat_open,
      sat_sale: @survey.sat_sale,
      sell_ebay: @survey.sell_ebay,
      skill_carpentry: @survey.skill_carpentry,
      skill_coordination: @survey.skill_coordination,
      skill_drawing: @survey.skill_drawing,
      skill_fundraising: @survey.skill_fundraising,
      skill_grants: @survey.skill_grants,
      skill_graphic_design: @survey.skill_graphic_design,
      skill_newsletter: @survey.skill_newsletter,
      skill_photography: @survey.skill_photography,
      skill_programming: @survey.skill_programming,
      skill_videography: @survey.skill_videography,
      taken_overhaul: @survey.taken_overhaul,
      taken_tuneup: @survey.taken_tuneup,
      thurs_open: @survey.thurs_open,
      thurs_youth: @survey.thurs_youth,
      tues_open: @survey.tues_open,
      tues_vol: @survey.tues_vol,
      worker_id: @survey.worker_id
    }

    patch :update, id: @survey, survey: survey_hash
    assert_redirected_to survey_path(assigns(:survey))
  end

  test "should destroy survey" do
    assert_difference('Survey.count', -1) do
      delete :destroy, id: @survey
    end

    assert_redirected_to surveys_path
  end
end
