defmodule PageObject.Actions.Clickable do
  defmacro clickable(action_name, css_selector, _opts \\ []) do
    quote do
      Module.register_attribute(__MODULE__, :clickables, accumulate: true)
      scope = Module.get_attribute(__MODULE__, :scope) || ""

      @clickables {unquote(action_name), scope <> unquote(css_selector)}

      # If clickable is scoped to a collection then only generate a submit method that takes an element
      # if not then it will click the selector provided.

      # scoped example:
      # Page.Collection.get(0) |> Page.Collection.submit

      # unscoped example:
      # Page.submit ()

      if (scope != "") do
        def unquote(action_name)(el) do
          IO.puts "clicking specific element"
        end
      else
        def unquote(action_name)() do
          selector = @clickables[unquote(action_name)]

          IO.puts "clicking: " <> selector
        end
      end

    end
  end
end
