defmodule Todo.List do
  use Ecto.Model

  # mix ecto.gen.migration create_lists
  schema "items" do
    # id field is implicit
    field :name, :string
    field :body, :string

    timestamps()
  end

  def changeset(item, params \\ %{}) do
    item
    |> cast(params, [:name, :body])
  end
end
