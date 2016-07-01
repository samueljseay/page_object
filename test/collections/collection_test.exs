defmodule CollectionTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  defmodule IndexPage do
    use PageObject

    collection :things, item_scope: "ul .thing" do
      text :title, "a.title"
      attribute :special_attr, "data-special-attr", "a.title"
    end
  end

  test "collection is scoped to the item_scope" do
    navigate_to "http://localhost:4000/index.html"
    assert Enum.count(IndexPage.Things.all) == 5
  end

  test "collection scopes queries to the item_scope" do
    navigate_to "http://localhost:4000/index.html"

    last_item_title =
      IndexPage.Things.get(4)
      |> IndexPage.Things.title

    first_special_attr =
      IndexPage.Things.get(0)
      |> IndexPage.Things.special_attr

    assert last_item_title == "Thing #5"
    assert first_special_attr == "thing-1"
  end
end
