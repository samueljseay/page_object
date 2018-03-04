defmodule PageObject.Queries.IsSelected do
  @moduledoc """
    A module wrapper for the is_selected? query macro
  """

  @doc """
    Defines a module function that determines if a radio button or a checkbox element on an html page is checked. The function name is derived
    by `name`. When scoped to a collection the function takes an element as an argument.

    ## Example

    ```
    #not in a collection
    defmodule MyPage do
      use PageObject

      is_selected? :is_service_agreement_accepted?, ".service-agreement"
    end

    # returns whether the element ".service-agreement" is checked on the page
    MyPage.is_service_agreement_accepted?
    ```

    ```
    #in a collection
    defmodule MyPage do
      use PageObject

      collection :things, item_scope: ".thing" do
        is_selected? :is_checked?, ".checkbox"
      end
    end

    # returns whether an element with class ".checkbox" is checked within the 0th ".thing"
    MyPage.Things.get(0)
    |> MyPage.Things.is_checked?
    ```
  """
  defmacro is_selected?(name, css_selector, _opts \\ []) do
    quote do
      scope = Module.get_attribute(__MODULE__, :scope) || ""

      if scope == "" do
        def unquote(name)() do
          Hound.Helpers.Element.selected?({:css, unquote(css_selector)})
        end
      else
        def unquote(name)(el) do
          case search_within_element(el, :css, unquote(css_selector)) do
            {:error, _} -> false
            {:ok, element} -> Hound.Helpers.Element.selected?(element)
          end
        end
      end
    end
  end
end
