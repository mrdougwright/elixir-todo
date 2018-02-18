defmodule TodoTest do
  use ExUnit.Case
  use Plug.Test

  @router_opts Todo.init([])
  test "returns an item" do
    conn = conn(:get, "/todo/1")
    conn = Todo.call(conn, @router_opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert String.match?(conn.resp_body, ~r/List Item/)
  end
end
