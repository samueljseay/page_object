defmodule PageObject.Actions.Clickable do
  @moduledoc """
    A module wrapper for the clickable action macro
  """

  @doc """
    Defines a module function that can perform a click action on an element. The function name
    is derived by `action_name`.

    When scoped to a collection it requires an element be passed to the action.

    ## Example

    ```
    # without a collection
    defmodule MyPage do
      use PageObject

      clickable :submit, "form button"
    end

    # click form submit button
    MyPage.submit

    # with a collection
    defmodule MyPage do
      use PageObject

      collection :things, ".thing" do
        clickable :submit, "button"
      end
    end

    # click button of 0th item in things
    |> MyPage.Things.get(0)
    MyPage.Things.submit
    ```
  """
  defmacro clickable(action_name, css_selector, _opts \\ []) do
    quote do
      scope = Module.get_attribute(__MODULE__, :scope) || ""

      if (scope == "") do
        def unquote(action_name)() do
          find_element(:css, unquote(css_selector))
          |> click
        end
      else
        def unquote(action_name)(el) do
          el
          |> find_within_element(:css, unquote(css_selector))
          |> click
        end
      end
    end
  end
end
