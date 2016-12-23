defmodule IndexPage do
  use PageObject

  visitable :visit, "http://localhost:4000/index.html"

  fillable :fill_email, "input[name='email']"
  value :email_value, "input[name='email']"

  fillable :fill_username, "input[name='username']"
  value :username_value, "input[name='username']"

  fillable :fill_choice, "select[name='choice']", clear: false
  value :choice_value, "select[name='choice']"

  collection :things, item_scope: "ul .thing" do
    value :text_input, "input[type='text']"
    fillable :fill_input, "input[type='text']"
  end
end

defmodule FillableTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  import IndexPage

  test "using fillable changes an input value" do
    IndexPage
    |> visit

    assert IndexPage.email_value == "test@example.com"
    assert IndexPage.username_value == "testuser"

    IndexPage.fill_email "new@example.com"

    assert IndexPage.email_value == "new@example.com"

    IndexPage.fill_username "newuser"

    assert IndexPage.username_value == "newuser"
  end

  test "fillable in a collection is scoped to the item_scope" do
    IndexPage
    |> visit

    IndexPage.Things.get(3)
    |> IndexPage.Things.fill_input("a brand new value")

    new_val =
      IndexPage.Things.get(3)
      |> IndexPage.Things.text_input

    assert new_val == "a brand new value"
  end

  test "can chain visitable and fillable" do
    IndexPage
      |> visit
      |> fill_email("new@example.com")

    assert IndexPage.email_value == "new@example.com"
  end

  test "can fill a select" do
    IndexPage
      |> visit
      |> fill_choice("vanilla")

    assert IndexPage.choice_value == "vanilla"
  end
end
