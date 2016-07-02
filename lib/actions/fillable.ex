defmodule PageObject.Actions.Fillable do
  defmacro fillable(action_name, css_selector, _opts \\ []) do
    quote do
      scope = Module.get_attribute(__MODULE__, :scope) || ""

      if (scope == "") do
        def unquote(action_name)(value) do
          find_element(:css, unquote(css_selector))
          |> fill_field(value)
        end
      else
        def unquote(action_name)(el, value) do
          el
          |> find_within_element(:css, unquote(css_selector))
          |> fill_field(value)
        end
      end
    end
  end
end
