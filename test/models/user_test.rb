require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      email: "test@example.com",
      password: "password123",
      name: "Test User"
    )
  end

  test "should be valid with valid attributes" do
    assert @user.valid?
  end

  test "should require email" do
    @user.email = nil
    assert_not @user.valid?
    assert_includes @user.errors[:email], "can't be blank"
  end

  test "should require unique email" do
    @user.save
    duplicate_user = @user.dup
    assert_not duplicate_user.valid?
    assert_includes duplicate_user.errors[:email], "has already been taken"
  end

  test "should normalize email to lowercase" do
    @user.email = "Test@Example.COM"
    @user.save
    assert_equal "test@example.com", @user.reload.email
  end

  test "should require valid email format" do
    @user.email = "invalid-email"
    assert_not @user.valid?
    assert_includes @user.errors[:email], "is invalid"
  end

  test "should require password" do
    @user.password = nil
    assert_not @user.valid?
  end

  test "should require password minimum length" do
    @user.password = "short"
    assert_not @user.valid?
    assert_includes @user.errors[:password], "is too short (minimum is 8 characters)"
  end

  test "should authenticate with correct password" do
    @user.save
    assert @user.authenticate("password123")
  end

  test "should not authenticate with incorrect password" do
    @user.save
    assert_not @user.authenticate("wrongpassword")
  end

  test "should normalize name" do
    @user.name = "  John Doe  "
    @user.save
    assert_equal "John Doe", @user.reload.name
  end

  test "should allow blank name" do
    @user.name = nil
    assert @user.valid?
  end

  test "should limit name length" do
    @user.name = "a" * 101
    assert_not @user.valid?
    assert_includes @user.errors[:name], "is too long (maximum is 100 characters)"
  end
end
