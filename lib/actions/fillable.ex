defmodule PageObject.Actions.Fillable do
  @moduledoc """
    A module wrapper for the fillable action macro
  """

  @doc """
    Defines a module function that can fill an input with a value. The function name
    is derived by `action_name`.

    When scoped to a collection it requires an element be passed to the action.

    ## Example

    ```
    # without a collection
    defmodule MyPage do
      use PageObject

      fillable :email, "input[type='email']"
    end

    # click form submit button
    MyPage.email("demo@example.com")

    # with a collection
    defmodule MyPage do
      use PageObject

      collection :things, ".thing" do
        fillable :email, "input[type='email']"
      end
    end

    # fill input of 0th item in things
    |> MyPage.Things.get(0)
    MyPage.Things.email("demo@example.com")
    ```
  """
  defmacro fillable(action_name, css_selector, _opts \\ []) do
    quote do
      scope = Module.get_attribute(__MODULE__, :scope) || ""

      if (scope == "") do
        def unquote(action_name)(module \\ __MODULE__, value) do
          find_element(:css, unquote(css_selector))
          |> fill_field(value)
          module
        end
      else
        def unquote(action_name)(module \\ __MODULE__, el, value) do
          el
          |> find_within_element(:css, unquote(css_selector))
          |> fill_field(value)
          module
        end
      end
    end
  end
end
