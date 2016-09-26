defmodule ClickablePage do
  use PageObject

  visitable :visit, "http://localhost:4000/index.html"
  clickable :click_show, "#show-hidden"
  attribute :hidden_style, "style", "#hidden"
end

defmodule ClickableTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  import ClickablePage

  test "clicking the show-hidden button causes an element to come into view" do
    ClickablePage.visit

    assert ClickablePage.hidden_style == "display: none;"
    ClickablePage.click_show
    assert ClickablePage.hidden_style == "display: block;"
  end

  test "chaining click and show works" do
    ClickablePage
      |> visit
      |> click_show

    assert ClickablePage.hidden_style == "display: block;"
  end
end
