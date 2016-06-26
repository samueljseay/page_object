defmodule PageObject.Actions.Visitable do
  alias PageObject.Util.Url

  defmacro visitable(action_name, url) do
    quote do
      Module.register_attribute(__MODULE__, :visitables, accumulate: true)

      @visitables {unquote(action_name), unquote(url)}

      def unquote(action_name)(segments \\ []) do
        url = @visitables[unquote(action_name)]
        url_parts = Url.convert_url_to_dynamic_segments(url)
        url =
          Enum.reduce(segments, url, fn({segment_key, segment_value}, acc) ->
            case Url.is_query_string?(segment_key, url_parts) do
              true ->
                Url.put_query_string(acc, segment_key, segment_value)
              false ->
                String.replace(
                  acc,
                  ":" <> Atom.to_string(segment_key),
                  to_string(segment_value)
                )
            end
          end)

        IO.puts "visiting: " <> url
      end
    end
  end
end