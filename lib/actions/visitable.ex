defmodule PageObject.Actions.Visitable do
  @moduledoc """
    A module wrapper for the visitable action macro
  """

  @doc """
    Defines a module function that can visit a url with dynamic segments in it.
    It supports query parameters as additional arguments.

    ## Examples
    ```
    defmodule DashboardPage do
      use PageObject

      visitable :visit, "http://localhost:4001/:account_id/dashboard"
    end

    # visit http://localhost:4001/1/dashboard
    DashboardPage.visit(account_id: 1)

    # visit http://localhost:4001/1/dashboard?filter="foo"
    DashboardPage.visit(account_id: 1, filter: "foo")
    ```
  """
  alias PageObject.Util.Url

  defmacro visitable(action_name, url) do
    quote do
      def unquote(action_name)(segments \\ []) do
        url = unquote(url)
        url_parts = Url.convert_url_to_dynamic_segments(url)
        url =
          Enum.reduce(segments, url, fn({segment_key, segment_value}, acc) ->
            # TODO replace with URI module usage
            case Url.is_query_string?(segment_key, url_parts) do
              true ->
                Url.put_query_string(acc, segment_key, segment_value)
              false ->
                String.replace(
                  acc,
                  ":" <> Atom.to_string(segment_key),
                  URI.encode(to_string(segment_value))
                )
            end
          end)

        navigate_to(url)
      end
    end
  end
end
