defmodule Todo.Repo do
  use Ecto.Repo,
    otp_app: :todo,
    adapater: Sqlite.Ecto
end
