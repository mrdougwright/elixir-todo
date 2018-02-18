defmodule Todo.App do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the db when the application starts
      supervisor(Todo.Repo, []),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Todo.App.Supervisor]
    Supervisor.start_link(children, opts)
    IO.puts "Server running...\n"
    {:ok, pid} = Plug.Adapters.Cowboy.http Todo, []
  end
end
