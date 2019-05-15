defmodule Web do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  def child_spec(_arg) do
    Plug.Cowboy.child_spec(
      scheme: :http,
      options: [port: Application.fetch_env!(:fibonacci, :port)],
      plug: __MODULE__
    )
  end

  get("/", do: send_resp(conn, 200, "Great Router Configured"))

  match _ do
    Plug.Conn.send_resp(conn, 404, "not found")
  end
end
