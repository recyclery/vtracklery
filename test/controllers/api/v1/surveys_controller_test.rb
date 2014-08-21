require 'test_helper'

class Api::V1::SurveysControllerTest < ActionController::TestCase
  setup do
    @survey = surveys(:one)
    @request.headers['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(Settings.api.login, Settings.api.password)
  end

  test "should get index" do
    xhr :get, :index, @authentication
    assert_response :success
    assert_not_nil assigns(:surveys)
  end

  test "should create survey" do
    worker = Worker.create(name: "non-survey worker")
    assert_difference('Survey.count') do
      survey_hash = {
        worker_name: worker.name,
        assist_host: @survey.assist_host,
        host_program: @survey.host_program,
        greet_open: @survey.greet_open,
        frequency: @survey.frequency,
        tues_vol: @survey.tues_vol,
        tues_open: @survey.tues_open,
        thurs_youth: @survey.thurs_youth,
        thurs_open: @survey.thurs_open,
        fri_vol: @survey.fri_vol,
        sat_sale: @survey.sat_sale,
        sat_open: @survey.sat_open,
        can_name_bike: @survey.can_name_bike,
        can_fix_flat: @survey.can_fix_flat,
        can_replace_tire: @survey.can_replace_tire,
        can_replace_seat: @survey.can_replace_seat,
        can_replace_cables: @survey.can_replace_cables,
        can_adjust_brakes: @survey.can_adjust_brakes,
        can_adjust_derailleurs: @survey.can_adjust_derailleurs,
        can_replace_brakes: @survey.can_replace_brakes,
        can_replace_shifters: @survey.can_replace_shifters,
        can_remove_pedals: @survey.can_remove_pedals,
        replace_crank: @survey.replace_crank,
        can_adjust_bearing: @survey.can_adjust_bearing,
        can_overhaul_hubs: @survey.can_overhaul_hubs,
        can_overhaul_bracket: @survey.can_overhaul_bracket,
        can_overhaul_headset: @survey.can_overhaul_headset,
        can_true_wheels: @survey.can_true_wheels,
        can_replace_fork: @survey.can_replace_fork,
        assist_youth: @survey.assist_youth,
        assist_tuneup: @survey.assist_tuneup,
        assist_overhaul: @survey.assist_overhaul,
        pickup_donations: @survey.pickup_donations,
        taken_tuneup: @survey.taken_tuneup,
        taken_overhaul: @survey.taken_overhaul,
        drive_stick: @survey.drive_stick,
        have_vehicle: @survey.have_vehicle,
        represent_recyclery: @survey.represent_recyclery,
        sell_ebay: @survey.sell_ebay,
        organize_drive: @survey.organize_drive,
        organize_events: @survey.organize_events,
        skill_graphic_design: @survey.skill_graphic_design,
        skill_drawing: @survey.skill_drawing,
        skill_photography: @survey.skill_photography,
        skill_videography: @survey.skill_videography,
        skill_programming: @survey.skill_programming,
        skill_grants: @survey.skill_grants,
        skill_newsletter: @survey.skill_newsletter,
        skill_carpentry: @survey.skill_carpentry,
        skill_coordination: @survey.skill_coordination,
        skill_fundraising: @survey.skill_fundraising,
        comment: @survey.comment,
        created_at: @survey.created_at,
        updated_at: @survey.updated_at
      }
      xhr :post, :create, survey: survey_hash
    end

    assert_response :success
  end

  test "should show survey" do
    xhr :get, :show, id: @survey
    assert_response :success
  end

  test "should update survey" do
    survey_hash = {
      assist_host: @survey.assist_host,
      host_program: @survey.host_program,
      greet_open: @survey.greet_open,
      frequency: @survey.frequency,
      tues_vol: @survey.tues_vol,
      tues_open: @survey.tues_open,
      thurs_youth: @survey.thurs_youth,
      thurs_open: @survey.thurs_open,
      fri_vol: @survey.fri_vol,
      sat_sale: @survey.sat_sale,
      sat_open: @survey.sat_open,
      can_name_bike: @survey.can_name_bike,
      can_fix_flat: @survey.can_fix_flat,
      can_replace_tire: @survey.can_replace_tire,
      can_replace_seat: @survey.can_replace_seat,
      can_replace_cables: @survey.can_replace_cables,
      can_adjust_brakes: @survey.can_adjust_brakes,
      can_adjust_derailleurs: @survey.can_adjust_derailleurs,
      can_replace_brakes: @survey.can_replace_brakes,
      can_replace_shifters: @survey.can_replace_shifters,
      can_remove_pedals: @survey.can_remove_pedals,
      replace_crank: @survey.replace_crank,
      can_adjust_bearing: @survey.can_adjust_bearing,
      can_overhaul_hubs: @survey.can_overhaul_hubs,
      can_overhaul_bracket: @survey.can_overhaul_bracket,
      can_overhaul_headset: @survey.can_overhaul_headset,
      can_true_wheels: @survey.can_true_wheels,
      can_replace_fork: @survey.can_replace_fork,
      assist_youth: @survey.assist_youth,
      assist_tuneup: @survey.assist_tuneup,
      assist_overhaul: @survey.assist_overhaul,
      pickup_donations: @survey.pickup_donations,
      taken_tuneup: @survey.taken_tuneup,
      taken_overhaul: @survey.taken_overhaul,
      drive_stick: @survey.drive_stick,
      have_vehicle: @survey.have_vehicle,
      represent_recyclery: @survey.represent_recyclery,
      sell_ebay: @survey.sell_ebay,
      organize_drive: @survey.organize_drive,
      organize_events: @survey.organize_events,
      skill_graphic_design: @survey.skill_graphic_design,
      skill_drawing: @survey.skill_drawing,
      skill_photography: @survey.skill_photography,
      skill_videography: @survey.skill_videography,
      skill_programming: @survey.skill_programming,
      skill_grants: @survey.skill_grants,
      skill_newsletter: @survey.skill_newsletter,
      skill_carpentry: @survey.skill_carpentry,
      skill_coordination: @survey.skill_coordination,
      skill_fundraising: @survey.skill_fundraising,
      comment: @survey.comment,
      created_at: @survey.created_at,
      updated_at: @survey.updated_at
    }
    xhr :patch, :update, id: @survey, survey: survey_hash

    assert_response :success
  end

  test "should destroy survey" do
    assert_difference('Survey.count', -1) do
      xhr :delete, :destroy, id: @survey
    end

    assert_response :success
  end
end
