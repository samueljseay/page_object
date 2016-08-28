defmodule PageObject.Actions.Visitable do
  @moduledoc """
    A module wrapper for the visitable action macro
  """

  @doc """
    Defines a module function that can visit a url with dynamic segments in it.
    It supports query parameters as additional arguments.

    Also generates a method appending _url for asserting that the current_url matches the one derived
    for the visitable.

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

    # assert urls match
    assert current_url = DashboardPage.visit_url(account_id: 1, filter: "foo")
    ```

  """
  alias PageObject.Util.Url

  defmacro visitable(action_name, url) do
    quote do
      defp get_url(url, segments) do
        url_parts = Url.convert_url_to_dynamic_segments(url)

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
      end

      def unquote(action_name)(segments \\ []) do
        unquote(url)
        |> get_url(segments)
        |> navigate_to
      end

      def unquote(:"#{action_name}_url")(segments \\ []) do
        get_url(unquote(url), segments)
      end
    end
  end
end
