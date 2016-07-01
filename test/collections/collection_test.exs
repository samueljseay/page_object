defmodule CollectionTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  defmodule IndexPage do
    use PageObject

    collection :things, item_scope: "ul .thing" do
      text :text, "li"
    end
  end

  test "collection is scoped to the item_scope" do
    navigate_to "http://localhost:4000/index.html"
    assert Enum.count(IndexPage.Things.all) == 5
  end

  test "collection scopes queries to the item_scope" do
    navigate_to "http://localhost:4000/index.html"

    last_item_text =
      IndexPage.Things.get(4)
      |> IndexPage.Things.text

    assert last_item_text == "Thing #5"
  end
end
