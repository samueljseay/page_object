defmodule PageObject.Util.Url do
  @moduledoc """
    A group of URL helpers used in visitable macro currently. These will be mostly replaced by usage of the URI module
    in future.
  """

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
    encoded_param =
      query_param
      |> to_string
      |> URI.encode

    encoded_val =
      val
      |> to_string
      |> URI.encode

    case String.contains?(url, "?") do
      true -> url <> "&#{encoded_param}=#{encoded_val}"
      false -> url <> "?#{encoded_param}=#{encoded_val}"
    end
  end
end
