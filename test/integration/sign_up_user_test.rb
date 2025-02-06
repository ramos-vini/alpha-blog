require "test_helper"

class SignUpUserTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.new(username: "Test User 1", email: "testuser1@email.com", password: "password123")
  end

  test "get signup page and create user" do
    get signup_path
    assert_response :success

    assert_difference 'User.count', 1 do
      post users_path, params: {user: {
        username: @user.username,
        email: @user.email,
        password: @user.password
        }
      }
    end

    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_match @user.username, response.body
  end
end
