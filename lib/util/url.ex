defmodule PageObject.Util.Url do
  def convert_url_to_dynamic_segments(url) do
    url
    |> split
    |> Enum.filter(fn url -> dynamic_segment?(url) end)
    |> Enum.map(fn segment ->
      segment
      |> String.replace(":", "")
      |> String.to_atom
    end)
  end

  # borrowed from Plug.Router.Utils
  def split(url) do
    for segment <- String.split(url, "/"), segment != "", do: segment
  end

  def dynamic_segment?(segment) do
    String.starts_with?(segment, ":")
  end

  def is_query_string?(segment, segment_list) do
    ! Enum.any?(segment_list, fn atom -> segment == atom end)
  end

  def put_query_string(url, query_param, val) do
    case String.contains?(url, "?") do
      true -> url <> "&#{query_param}=#{val}"
      false -> url <> "?#{query_param}=#{val}"
    end
  end
end
