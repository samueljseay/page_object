defmodule PageObject.Actions.Clickable do
  defmacro clickable(action_name, css_selector, _opts \\ []) do
    quote do
      scope = Module.get_attribute(__MODULE__, :scope) || ""

      # If clickable is scoped to a collection then only generate a submit method that takes an element
      # if not then it will click the selector provided.

      # scoped example:
      # Page.Sites.get(0) |> Page.Sites.click

      # unscoped example:
      # Page.click

      if (scope != "") do
        def unquote(action_name)(el) do
          IO.puts "clicking specific element"
        end
      else
        def unquote(action_name)() do
          selector = unquote(css_selector)

          IO.puts "clicking: " <> selector
        end
      end

    end
  end
end
