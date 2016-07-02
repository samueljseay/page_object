defmodule AttributeTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  defmodule IndexPage do
    use PageObject

    attribute :input_placeholder, "placeholder", "#input-attribute-1"
    attribute :radio_checked, "checked", "#radio-attribute-1"
  end

  test "can query the attributes of an element" do
    navigate_to "http://localhost:4000/index.html"

    assert IndexPage.input_placeholder == "placeholder text"
    assert IndexPage.radio_checked == "true"
  end
end
