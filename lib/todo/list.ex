defmodule Todo.List do
  use Ecto.Model

  # mix ecto.gen.migration create_lists
  schema "items" do
    # id field is implicit
    field :name, :string
    field :body, :string

    timestamps()
  end
end
