defmodule TextTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  defmodule IndexPage do
    use PageObject

    text :heading, "header h2"
    text :sub_heading, "header h3"
  end

  test "can query the text of an element" do
    navigate_to "http://localhost:4000/index.html"

    assert IndexPage.heading == "The main heading"
    assert IndexPage.sub_heading == "The sub heading"
  end
end
