defmodule Todo do

  # server methods

  # init/1 is called once when the server is started
  def init(default_opts) do
    IO.puts "starting up Todo..."
    default_opts
  end

  # call/2 is called every time a new request comes in.
  def call(conn, _opts) do
    IO.puts "saying hello!"
    Plug.Conn.send_resp(conn, 200, "Hello, world!")
  end
end
