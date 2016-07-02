defmodule PageObject.Queries.Value do
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
