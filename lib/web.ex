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

  get("/fibonacci") do
    conn = Plug.Conn.fetch_query_params(conn)

    numbers =
      conn.params
      |> Map.fetch!("numbers")
      |> String.split(",")

    {:ok, resp} =
      case length(numbers) do
        1 ->
          {key, _} = Integer.parse(hd(numbers))
          Fibonacci.calculate(key)

        _ ->
          numbers
          |> Enum.map(fn x ->
            {key, _} = Integer.parse(x)
            key
          end)
          |> Fibonacci.calculate()
      end

    send_resp(conn, 200, Jason.encode!(%{resp: resp}))
  end

  get("/fibonacci/history") do
    {:ok, resp} = Fibonacci.history()

    send_resp(conn, 200, Jason.encode!(%{resp: resp |> Enum.into(%{})}))
  end

  get("/fibonacci/history/count") do
    {:ok, resp} = Fibonacci.history_count()

    send_resp(conn, 200, Jason.encode!(%{resp: resp}))
  end

  match _ do
    Plug.Conn.send_resp(conn, 404, "not found")
  end
end
