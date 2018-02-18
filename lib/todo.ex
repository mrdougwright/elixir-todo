defmodule Todo do
  # server methods

  # init/1 is called once when the server is started
  def init(default_opts) do
    IO.puts "starting up Todo..."
    default_opts
  end

  # call/2 is called every time a new request comes in.
  def call(conn, _opts) do
    route(conn.method, conn.path_info, conn)
  end

  # client methods

  def route("GET", ["hello"], conn) do
    send_response(conn, 200, "Hello, world!")
  end

  def route("GET", ["todo", item], conn) do
    case Todo.Repo.get(Todo.List, item) do
      nil ->
        send_response(conn, 404, "List with id #{item} not found.")
      item ->
        page_contents = EEx.eval_file("templates/show_item.eex", [item: item])
        conn
        |> Plug.Conn.put_resp_content_type("text/html")
        |> send_response(200, page_contents)
    end
  end

  def route(_method, _path, conn) do
    # this route is called if no other routes match
    send_response(conn, 404, "Couldn't find that page, sorry!")
  end

  defp send_response(conn, status, msg) do
    Plug.Conn.send_resp(conn, status, msg)
  end
end
