defmodule ClickableTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  defmodule IndexPage do
    use PageObject

    visitable :visit, "http://localhost:4000/index.html"
    clickable :click_show, "#show-hidden"
    attribute :hidden_style, "style", "#hidden"
  end

  test "clicking the show-hidden button causes an element to come into view" do
    IndexPage.visit

    assert IndexPage.hidden_style == "display: none;"
    IndexPage.click_show
    assert IndexPage.hidden_style == "display: block;"
  end
end
