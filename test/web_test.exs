defmodule WebTest do
  use ExUnit.Case
  use Plug.Test

  alias Web

  @init Web.init([])

  test "calculate_value" do
    conn =
      conn(:get, "/fibonacci?numbers=3")
      |> Web.call(@init)

    assert conn.status == 200
    assert conn.resp_body == Jason.encode!(%{resp: 2})
  end

  test "calculate_value for multiple valuess" do
    conn =
      conn(:get, "/fibonacci?numbers=3,4,5")
      |> Web.call(@init)

    assert conn.status == 200
    assert conn.resp_body == Jason.encode!(%{resp: [2, 3, 5]})
  end

  test "history" do
    conn =
      conn(:get, "/fibonacci/history")
      |> Web.call(@init)

    assert conn.status == 200
    assert conn.resp_body == Jason.encode!(%{resp: []})
  end

  test "history_count" do
    conn =
      conn(:get, "/fibonacci/history/count")
      |> Web.call(@init)

    assert conn.status == 200
    assert conn.resp_body == Jason.encode!(%{resp: %{}})
  end
end
