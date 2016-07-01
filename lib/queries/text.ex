defmodule PageObject.Queries.Text do
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
