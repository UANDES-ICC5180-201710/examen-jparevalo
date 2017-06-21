require 'test_helper'

class PurcharsesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @purcharse = purcharses(:one)
  end

  test "should get index" do
    get purcharses_url
    assert_response :success
  end

  test "should get new" do
    get new_purcharse_url
    assert_response :success
  end

  test "should create purcharse" do
    assert_difference('Purcharse.count') do
      post purcharses_url, params: { purcharse: { game_id: @purcharse.game_id, user_id: @purcharse.user_id } }
    end

    assert_redirected_to purcharse_url(Purcharse.last)
  end

  test "should show purcharse" do
    get purcharse_url(@purcharse)
    assert_response :success
  end

  test "should get edit" do
    get edit_purcharse_url(@purcharse)
    assert_response :success
  end

  test "should update purcharse" do
    patch purcharse_url(@purcharse), params: { purcharse: { game_id: @purcharse.game_id, user_id: @purcharse.user_id } }
    assert_redirected_to purcharse_url(@purcharse)
  end

  test "should destroy purcharse" do
    assert_difference('Purcharse.count', -1) do
      delete purcharse_url(@purcharse)
    end

    assert_redirected_to purcharses_url
  end
end
