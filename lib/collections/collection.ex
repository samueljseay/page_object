defmodule PageObject.Collections.Collection do
  @moduledoc """
    Collections are used to scope a CSS query to multiple page elements that follow the same html structure.

    This allows you to interact with each element in a consistent and expressive manner in your tests.

    Collections currently support all the actions and queries available in PageObject, allowing you to query specific
    attributes of collection items or interact with actionable parts of any collection item.
  """

  @doc """

    defines a collection scope based on `:item_scope` passed in to opts. A camelized module is generated from the `collection_name`. the `:item_scope`
    is used to generate a css selector scope that queries and actions defined within the block can use.

    The module generates 2 functions for querying the items in the collection:

    `all` which returns all items in the collection and `get(index)` which returns the item at passed `index`

    ## Example

    ```
    defmodule MyPage do
      # make the collection macro available via PageObject
      use PageObject

      collection :menu_items, item_scope: ".menu .item" do
        # all DOM related query and action macros called here will have their selectors scoped to ".menu .item"
        # and will be available as methods on the generated collection module: `MyPage.MenuItems`
        clickable :click, "a"
      end
    end

    # test usage
    test "I can logout by clicking the last menu item" do
      # get the last menu item
      MyPage.MenuItems.all
      |> List.last
      # most scoped and queries with scope take a Hound Element as the first argument
      |> MyPage.MenuItems.click
    end
    ```
  """
  defmacro collection(collection_name, opts, do: block) do
    generate_module(collection_name, opts, block)
  end

  @doc """
    The same as `collection/3` but does not require a block passed in
  """
  defmacro collection(collection_name, opts) do
    generate_module(collection_name, opts)
  end

  defp generate_module(collection_name, opts, block \\ nil) do
    quote do
      module = Module.concat([__MODULE__, Inflex.camelize(unquote(to_string(collection_name)))])

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
