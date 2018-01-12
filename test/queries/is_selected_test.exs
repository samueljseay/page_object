defmodule IsSelectedPage do
  use PageObject

  visitable :visit, "http://localhost:4000/index.html"

  is_selected? :radio_1_selected?, "#radio-attribute-1"
  is_selected? :radio_2_selected?, "#radio-attribute-2"

  is_selected? :checkbox_1_selected?, "#checkbox-1"
  is_selected? :checkbox_2_selected?, "#checkbox-2"

  collection :things, item_scope: "ul .thing" do
    is_selected? :checkbox_selected?, ".thing-checkbox"
  end
end

defmodule IsSelectedTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  test "is_selected? detects whether an element is checked" do
    IsSelectedPage.visit

    assert IsSelectedPage.radio_1_selected?
    refute IsSelectedPage.radio_2_selected?
    assert IsSelectedPage.checkbox_1_selected?
    refute IsSelectedPage.checkbox_2_selected?
  end

  test "is_selected? in a collection is scoped to the item_scope" do
    IsSelectedPage.visit

    first_thing = IsSelectedPage.Things.get(0)

    refute IsSelectedPage.Things.checkbox_selected?(first_thing)

    fifth_thing = IsSelectedPage.Things.get(4)

    assert IsSelectedPage.Things.checkbox_selected?(fifth_thing)
  end
end
