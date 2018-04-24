defmodule PageObject.Queries.IsVisible do
  @moduledoc """
    A module wrapper for the is_visible? query macro
  """

  @doc """
    Defines a module function that determines when an element exists and is visible on the page. 
    The function name is derived by `name`. When scoped to a collection the function takes an
    element as an argument.

    ## Example

    ```
    #not in a collection
    defmodule MyPage do
      use PageObject

      is_visible? :modal_is_visible?, ".modal"
    end

    # returns whether an element with class "modal" exists and is visible on the page
    MyPage.modal_is_visible?
    ```

    ```
    #in a collection
    defmodule MyPage do
      use PageObject

      collection :things, item_scope: ".thing" do
        is_visible? :error_is_visible?, ".error"
      end
    end

    # returns whether an element with class "error" exists and is visible within the 0th ".thing"
    MyPage.Things.get(0)
    |> MyPage.Things.error_is_visible?
    ```
  """
  defmacro is_visible?(name, css_selector, _opts \\ []) do
    quote do
      scope = Module.get_attribute(__MODULE__, :scope) || ""

      if scope == "" do
        def unquote(name)() do
          with {:ok, el} <- Hound.Helpers.Page.search_element(:css, unquote(css_selector), 1),
               true <- Hound.Helpers.Element.element_displayed?(el)
          do
            true
          else
            _ -> false
          end
        end
      else
        def unquote(name)(parent) do
          with {:ok, el} <- Hound.Helpers.Page.search_within_element(parent, :css, unquote(css_selector), 1),
               true <- Hound.Helpers.Element.element_displayed?(el)
          do
            true
          else
            _ -> false
          end
        end
      end
    end
  end
end
