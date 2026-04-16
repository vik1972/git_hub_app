require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(
      email: "existing@example.com",
      password: "password123",
      name: "Existing User"
    )
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: {
        user: {
          email: "new@example.com",
          password: "password123",
          name: "New User"
        }
      }
    end

    assert_redirected_to user_url(User.last)
    assert_equal "User was successfully created.", flash[:notice]
  end

  test "should not create user with invalid params" do
    assert_no_difference("User.count") do
      post users_url, params: {
        user: {
          email: "",
          password: "short"
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: {
      user: {
        name: "Updated Name",
        email: "updated@example.com"
      }
    }

    assert_redirected_to user_url(@user)
    assert_equal "User was successfully updated.", flash[:notice]
    @user.reload
    assert_equal "Updated Name", @user.name
    assert_equal "updated@example.com", @user.email
  end

  test "should not update user with invalid params" do
    patch user_url(@user), params: {
      user: {
        email: ""
      }
    }

    assert_response :unprocessable_entity
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
    assert_equal "User was successfully destroyed.", flash[:notice]
  end
end
