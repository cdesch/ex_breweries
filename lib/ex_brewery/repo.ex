defmodule ExBrewery.Repo do
  use Ecto.Repo,
    otp_app: :ex_brewery,
    adapter: Ecto.Adapters.Postgres
  use Scrivener, page_size: 3
end
