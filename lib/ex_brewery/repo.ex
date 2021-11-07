defmodule ExBrewery.Repo do
  use Ecto.Repo,
    otp_app: :ex_brewery,
    adapter: Ecto.Adapters.Postgres
end
