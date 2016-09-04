defmodule PageObject.Queries.Text do
  @moduledoc """
    A module wrapper for the text query macro
  """

  @doc """
    Defines a module function that queries the text value of an element on an html page. The function name is derived
    by `name`. When scoped to a collection the function takes an element as an argument.

    ## Example

    ```
    #not in a collection
    defmodule MyPage do
      use PageObject

      text :heading, "h2"
    end

    # queries the text value of `h2` on the current page
    MyPage.heading
    ```

    ```
    #in a collection
    defmodule MyPage do
      use PageObject

      collection :things, item_scope: ".thing" do
        text :heading, "h2"
      end
    end

    # queries the text value of the 0th ".thing h2"
    MyPage.Things.get(0)
    |> MyPage.Things.heading
    ```
  """
  defmacro text(name, css_selector, _opts \\ []) do
    quote do
      scope = Module.get_attribute(__MODULE__, :scope) || ""

      if scope == "" do
        def unquote(name)() do
          find_element(:css, unquote(css_selector))
          |> inner_text
        end
      else
        def unquote(name)(el) do
          el
          |> find_within_element(:css, unquote(css_selector))
          |> inner_text
        end
      end
    end
  end
end
