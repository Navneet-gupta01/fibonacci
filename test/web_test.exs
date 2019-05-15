defmodule WebTest do
  use ExUnit.Case
  use Plug.Test

  alias Web

  @init Web.init([])

  test "calculate_value" do
    conn =
      conn(:get, "/fibonacci?number=3")
      |> Web.call(@init)

    assert conn.status == 200
    assert conn.resp_body == %{resp: 2}
  end
end
