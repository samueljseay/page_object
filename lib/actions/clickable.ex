defmodule PageObject.Actions.Clickable do
  defmacro clickable(action_name, css_selector, _opts \\ []) do
    quote do
      Module.register_attribute(__MODULE__, :clickables, accumulate: true)

      @clickables {unquote(action_name), unquote(css_selector)}

      def unquote(action_name)() do
        selector = @clickables[unquote(action_name)]

        IO.puts "clicking: " <> selector
      end
    end
  end
end
