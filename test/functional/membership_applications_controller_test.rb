require 'test_helper'

class MembershipApplicationsControllerTest < ActionController::TestCase
  setup do
    @membership_application = membership_applications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:membership_applications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create membership_application" do
    assert_difference('MembershipApplication.count') do
      post :create, :membership_application => @membership_application.attributes
    end

    assert_redirected_to membership_application_path(assigns(:membership_application))
  end

  test "should show membership_application" do
    get :show, :id => @membership_application.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @membership_application.to_param
    assert_response :success
  end

  test "should update membership_application" do
    put :update, :id => @membership_application.to_param, :membership_application => @membership_application.attributes
    assert_redirected_to membership_application_path(assigns(:membership_application))
  end

  test "should destroy membership_application" do
    assert_difference('MembershipApplication.count', -1) do
      delete :destroy, :id => @membership_application.to_param
    end

    assert_redirected_to membership_applications_path
  end
end
