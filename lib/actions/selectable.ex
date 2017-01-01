defmodule PageObject.Actions.Selectable do
  @moduledoc """
    A module wrapper for the selectable action macro
  """

  @doc """
    Defines a module function that can select an option by its label. The function name
    is derived by `action_name`.

    When scoped to a collection it requires an element be passed to the action.

    ## Example

    ```
    # without a collection
    defmodule MyPage do
      use PageObject

      selectable :hour, "select[name='hour']"
    end

    # click form submit button
    MyPage.hour("11")

    # with a collection
    defmodule MyPage do
      use PageObject

      collection :things, ".thing" do
        selectable :hour, "select[name='hour']"
      end
    end

    # fill select of 0th item in things
    |> MyPage.Things.get(0)
    MyPage.Things.hour("10")
    ```
  """
  defmacro selectable(action_name, css_selector, _opts \\ []) do
    quote do
      scope = Module.get_attribute(__MODULE__, :scope) || ""

      if (scope == "") do
        def unquote(action_name)(module \\ __MODULE__, value) do
          find_element(:css, unquote(css_selector))
          |> input_into_field(value)
          module
        end
      else
        def unquote(action_name)(module \\ __MODULE__, el, value) do
          el
          |> find_within_element(:css, unquote(css_selector))
          |> input_into_field(value)
          module
        end
      end
    end
  end
end
