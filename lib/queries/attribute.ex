defmodule PageObject.Queries.Attribute do
  @moduledoc """
    A module wrapper for the attribute query macro
  """

  @doc """
    Defines a module function that queries the attribute value of an element on an html page. The function name is derived
    by `name`. When scoped to a collection the function takes an element as an argument.

    ##Examples

    ```
    #not in a collection
    defmodule MyPage do
      use PageObject

      attribute :email_placeholder, "placeholder", "input[type='email']"
    end

    # queries the value of placeholder attribute on `input[type='email']` on the current page
    MyPage.email_placeholder
    ```

    ```
    #in a collection
    defmodule MyPage do
      use PageObject

      collection :things, item_scope: ".thing" do
        attribute :email_placeholder, "placeholder", "input[type='email']"
      end
    end

    # queries the value of the placeholder attribute of the 0th ".thing input[type='email']"
    MyPage.Things.get(0)
    |> MyPage.Things.email_placeholder
    ```
  """
  defmacro attribute(name, attr, css_selector, _opts \\ []) do
    quote do
      scope = Module.get_attribute(__MODULE__, :scope) || ""

      if scope == "" do
        def unquote(name)() do
          find_element(:css, unquote(css_selector))
          |> attribute_value(unquote(attr))
        end
      else
        def unquote(name)(el) do
          el
          |> find_within_element(:css, unquote(css_selector))
          |> attribute_value(unquote(attr))
          # some attributes give back inconsistent whitespace with different drivers, this eliminates that
          |> String.trim
        end
      end
    end
  end
end
