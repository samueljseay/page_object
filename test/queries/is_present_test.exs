defmodule IsPresentPage do
  require Logger

  use PageObject

  visitable :visit, "http://localhost:4000/index.html"
  is_present? :heading_is_present?, "h2"
  is_present? :hidden_is_present?, "#hidden"
  is_present? :footer_is_present?, "footer"

  collection :things, item_scope: "ul .thing" do
    is_present? :select_is_present?, "select"
  end
end

defmodule IsPresentTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  test "is_present? detects whether an element is present" do
    IsPresentPage.visit

    assert IsPresentPage.heading_is_present?
    assert IsPresentPage.hidden_is_present?
    refute IsPresentPage.footer_is_present?
  end

  test "is_present? in a collection is scoped to the item_scope" do
    IsPresentPage.visit

    third_select_present? = IsPresentPage.Things.get(2)
      |> IsPresentPage.Things.select_is_present?

    refute third_select_present?

    fourth_select_present? = IsPresentPage.Things.get(3)
      |> IsPresentPage.Things.select_is_present?

    assert fourth_select_present?
  end
end
