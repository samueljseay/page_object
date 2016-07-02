defmodule ValueTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  defmodule IndexPage do
    use PageObject

    value :email_input, "input[name='email']"
    value :username_input, "input[name='username']"
  end

  test "can query the value of an element" do
    navigate_to "http://localhost:4000/index.html"

    assert IndexPage.email_input == "test@example.com"
    assert IndexPage.username_input == "testuser"
  end
end
