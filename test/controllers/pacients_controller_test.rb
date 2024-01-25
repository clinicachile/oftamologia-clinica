require "test_helper"

class PacientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pacient = pacients(:one)
  end

  test "should get index" do
    get pacients_url
    assert_response :success
  end

  test "should get new" do
    get new_pacient_url
    assert_response :success
  end

  test "should create pacient" do
    assert_difference("Pacient.count") do
      post pacients_url, params: { pacient: { age: @pacient.age, email: @pacient.email, first_name: @pacient.first_name, last_name: @pacient.last_name, phone: @pacient.phone, run: @pacient.run } }
    end

    assert_redirected_to pacient_url(Pacient.last)
  end

  test "should show pacient" do
    get pacient_url(@pacient)
    assert_response :success
  end

  test "should get edit" do
    get edit_pacient_url(@pacient)
    assert_response :success
  end

  test "should update pacient" do
    patch pacient_url(@pacient), params: { pacient: { age: @pacient.age, email: @pacient.email, first_name: @pacient.first_name, last_name: @pacient.last_name, phone: @pacient.phone, run: @pacient.run } }
    assert_redirected_to pacient_url(@pacient)
  end

  test "should destroy pacient" do
    assert_difference("Pacient.count", -1) do
      delete pacient_url(@pacient)
    end

    assert_redirected_to pacients_url
  end
end
