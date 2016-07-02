defmodule PageObject.Collections.Collection do
  defmacro collection(collection_name, opts \\ [], do: block) do
    quote do
      module = Module.concat([__MODULE__, String.capitalize(unquote(to_string(collection_name)))])

      defmodule module do
        if ! Module.get_attribute(__MODULE__, :scope) do
          Module.register_attribute(module, :scope, accumulate: false)
        end

        Module.put_attribute(module, :scope, unquote(opts[:item_scope]) <> " ")

        use PageObject

        unquote(block)

        def get(index) do
          Enum.fetch!(find_all_elements(:css, unquote(opts[:item_scope])), index)
        end

        def all() do
          find_all_elements(:css, unquote(opts[:item_scope]))
        end

        Module.put_attribute(module, :scope, "")
      end
    end
  end
end
