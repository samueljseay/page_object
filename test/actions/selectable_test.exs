defmodule SelectablePage do
  use PageObject

  visitable :visit, "http://localhost:4000/index.html"

  selectable :select_number, "select[name='number']"
  value :number_value, "select[name='number']"

  collection :things, item_scope: "ul .thing" do
    value :select_value, "select"
    selectable :select_input, "select"
  end
end

defmodule SelectableTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  import SelectablePage

  test "using selectable changes a select value" do
    SelectablePage
    |> visit

    assert SelectablePage.number_value == "one"

    SelectablePage.select_number "Two"
    assert SelectablePage.number_value == "two"
  end

  test "selectable in a collection is scoped to the item_scope" do
    SelectablePage
    |> visit

    SelectablePage.Things.get(3)
    |> SelectablePage.Things.select_input("No")

    new_val =
      SelectablePage.Things.get(3)
      |> SelectablePage.Things.select_value

    assert new_val == "no"
  end

  test "can chain visitable and selectable" do
    SelectablePage
      |> visit
      |> select_number("Three")

    assert SelectablePage.number_value == "three"
  end
end
