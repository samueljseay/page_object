Application.ensure_all_started(:hound)

# A basic html server implementation for testing
defmodule HTMLServer do
  use Plug.Builder
  plug Plug.Logger
  plug Plug.Static, at: "/", from: :page_object

  plug :not_found

  def not_found(conn, _) do
    send_resp(conn, 404, "not found")
  end
end

Plug.Adapters.Cowboy.http HTMLServer, [], port: 4000

ExUnit.start()
