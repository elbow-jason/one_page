ExUnit.start

Mix.Task.run "ecto.create", ~w(-r OnePage.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r OnePage.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(OnePage.Repo)

