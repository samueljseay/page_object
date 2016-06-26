defmodule PageObject.Collections.Collection do
  defmacro collection(collection_name, opts \\ [], do: block) do
    quote do
      module = Module.concat([__MODULE__, String.capitalize(unquote(to_string(collection_name)))])

      defmodule module do
        Module.register_attribute(module, :scope, accumulate: false)
        Module.put_attribute(module, :scope, unquote(opts[:scope]) <> " ")

        use PageObject

        unquote(block)

        def count do
          IO.puts "count how many there are here"
        end

        def get(index) do
          "single element here"
        end
      end
    end
  end
end

# API might look like:
# DashboardPage.Things.get(0)
# |> DashboardPage.submit
