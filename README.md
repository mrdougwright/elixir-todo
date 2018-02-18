# Todo

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `todo` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:todo, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/todo](https://hexdocs.pm/todo).

### Guide
Start the server:
```shell
$ iex -S mix
iex> {:ok, pid} = Plug.Adapters.Cowboy.http Todo, []
```

After sqlite repo is connected, generate migration file:
```shell
$ mix ecto.gen.migration create_lists
```
Edit migration file and run
```shell
$ mix ecto.migrate
```

Edit  open iex shell and create the first list item:
```elixir
Todo.Repo.start_link
item = %Todo.List{id: 1, name: "elixir homework", body: "finish this tutorial"}
Todo.Repo.insert!(item)
```
