defmodule Todo do
  # server methods
  # require IEx

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

  # GET
  def route("GET", ["hello"], conn) do
    send_response(conn, 200, "Hello, world!")
  end

  def route("GET", ["todo", "new"], conn) do
    page_contents = EEx.eval_file("templates/new_item.eex")
    conn |> render_template(page_contents)
  end

  def route("GET", ["todo", item], conn) do
    case Todo.Repo.get(Todo.List, item) do
      nil ->
        send_response(conn, 404, "List with id #{item} not found.")
      item ->
        page_contents = EEx.eval_file("templates/show_item.eex", [item: item])
        conn |> render_template(page_contents)
    end
  end

  # POST
  def route("POST", ["create"], conn) do
    {:ok, body, conn} = Plug.Conn.read_body(conn)
    form = body |> String.split("&") |> Enum.map(fn(x) -> key_val(x) end)
    changeset = Todo.List.changeset(%Todo.List{}, %{name: form[:name], body: form[:body]})
    {:ok, item} = Todo.Repo.insert(changeset)
    if item do
      page_contents = EEx.eval_file("templates/show_item.eex", [item: item])
      conn |> render_template(page_contents)
    else
      send_response(conn, 500, "Server error!")
    end
  end

  # default
  def route(_method, _path, conn) do
    # this route is called if no other routes match
    send_response(conn, 404, "Couldn't find that page, sorry!")
  end

  defp key_val(str) do
    kv = String.split(str, "=")
    key = List.first(kv) |> String.to_atom
    val = List.last(kv)
    {key, val}
  end

  defp send_response(conn, status, msg) do
    Plug.Conn.send_resp(conn, status, msg)
  end

  defp render_template(conn, page_contents) do
    conn
    |> Plug.Conn.put_resp_content_type("text/html")
    |> send_response(200, page_contents)
  end
end
