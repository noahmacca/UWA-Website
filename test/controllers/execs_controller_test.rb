require 'test_helper'

class ExecsControllerTest < ActionController::TestCase
  setup do
    @exec = execs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:execs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create exec" do
    assert_difference('Exec.count') do
      post :create, exec: { exec_name: @exec.exec_name, program: @exec.program, responsibilities: @exec.responsibilities, team: @exec.team }
    end

    assert_redirected_to exec_path(assigns(:exec))
  end

  test "should show exec" do
    get :show, id: @exec
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @exec
    assert_response :success
  end

  test "should update exec" do
    patch :update, id: @exec, exec: { exec_name: @exec.exec_name, program: @exec.program, responsibilities: @exec.responsibilities, team: @exec.team }
    assert_redirected_to exec_path(assigns(:exec))
  end

  test "should destroy exec" do
    assert_difference('Exec.count', -1) do
      delete :destroy, id: @exec
    end

    assert_redirected_to execs_path
  end
end
