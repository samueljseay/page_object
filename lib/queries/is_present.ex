defmodule PageObject.Queries.IsPresent do
  @moduledoc """
    A module wrapper for the is_present? query macro
  """

  @doc """
    Defines a module function that determines the presence of an element on an html page. The function name is derived
    by `name`. When scoped to a collection the function takes an element as an argument.

    ## Example

    ```
    #not in a collection
    defmodule MyPage do
      use PageObject

      is_present? :warning_is_present?, ".warning"
    end

    # returns whether an element with class "warning" is present on the page
    MyPage.warning_is_present?
    ```

    ```
    #in a collection
    defmodule MyPage do
      use PageObject

      collection :things, item_scope: ".thing" do
        is_present? :error_is_present?, ".error"
      end
    end

    # returns whether an element with class "error" exists within the 0th ".thing"
    MyPage.Things.get(0)
    |> MyPage.Things.error_is_present?
    ```
  """
  defmacro is_present?(name, css_selector, _opts \\ []) do
    quote do
      scope = Module.get_attribute(__MODULE__, :scope) || ""

      if scope == "" do
        def unquote(name)() do
          Hound.Matchers.element?(:css, unquote(css_selector))
        end
      else
        def unquote(name)(el) do
          case search_within_element(el, :css, unquote(css_selector), 1) do
            {:error, _} -> false
            {:ok, _} -> true
          end
        end
      end
    end
  end
end
