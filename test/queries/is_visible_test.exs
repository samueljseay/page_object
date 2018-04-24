defmodule IsVisiblePage do
  require Logger

  use PageObject

  visitable :visit, "http://localhost:4000/index.html"
  is_visible? :heading_is_visible?, "h2"
  is_visible? :hidden_is_visible?, "#hidden"
  is_visible? :footer_is_visible?, "footer"

  collection :things, item_scope: "ul .thing" do
    is_visible? :title_is_visible?, ".title"
  end
end

defmodule IsVisibleTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  test "is_visible? returns true if the element exists and is visible" do
    IsVisiblePage.visit

    assert IsVisiblePage.heading_is_visible?
    refute IsVisiblePage.hidden_is_visible?
    refute IsVisiblePage.footer_is_visible?
  end

  test "is_visible? in a collection is scoped to the item_scope" do
    IsVisiblePage.visit

    third_title_visible? = IsVisiblePage.Things.get(2)
      |> IsVisiblePage.Things.title_is_visible?

    assert third_title_visible?

    sixth_title_visible? = IsVisiblePage.Things.get(5)
      |> IsVisiblePage.Things.title_is_visible?

    refute sixth_title_visible?
  end
end
