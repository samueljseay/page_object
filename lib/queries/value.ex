defmodule PageObject.Queries.Value do
  @moduledoc """
    A module wrapper for the value query macro
  """

  @doc """
    Defines a module function that queries the value of an element on an html page. This is relevant mostly to input elements.

    The function name is derived by `name`. When scoped to a collection the function takes an element as an argument.

    ## Example

    ```
    #not in a collection
    defmodule MyPage do
      use PageObject

      value :email_value, "input[type='email']"
    end

    # queries the value of `input[type='email']` on the current page
    MyPage.email_value
    ```

    ```
    #in a collection
    defmodule MyPage do
      use PageObject

      collection :things, item_scope: ".thing" do
        value :email_value, "input[type='email']"
      end
    end

    # queries the value of the 0th ".thing input[type='email']"
    MyPage.Things.get(0)
    |> MyPage.Things.email_value
    ```
  """
  defmacro value(name, css_selector, _opts \\ []) do
    quote do
      scope = Module.get_attribute(__MODULE__, :scope) || ""

      if scope == "" do
        def unquote(name)() do
          find_element(:css, unquote(css_selector))
          |> attribute_value(:value)
        end
      else
        def unquote(name)(el) do
          el
          |> find_within_element(:css, unquote(css_selector))
          |> attribute_value(:value)
        end
      end
    end
  end
end
