# API might look like:
# DashboardPage.Sites.all
# |> Enum.fetch(0)
# |> DashboardPage.Sites.visit
defmodule PageObject.Collections.Collection do
  defmacro collection(collection_name, opts \\ [], do: block) do
    quote do
      module = Module.concat([__MODULE__, String.capitalize(unquote(to_string(collection_name)))])

      def unquote(collection_name)() do
        IO.puts "shortcut to get all the elements"
      end

      defmodule module do
        if ! Module.get_attribute(__MODULE__, :scope) do
          Module.register_attribute(module, :scope, accumulate: false)
        end

        Module.put_attribute(module, :scope, unquote(opts[:scope]) <> " ")

        use PageObject

        unquote(block)

        def get(index) do
          IO.puts "single element here"
        end

        def all() do
          IO.puts "select all #{unquote(opts[:scope])}"
          []
        end

        Module.put_attribute(module, :scope, "")
      end
    end
  end
end
