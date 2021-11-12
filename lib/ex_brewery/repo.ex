defmodule ExBrewery.Repo do
  use Ecto.Repo,
    otp_app: :ex_brewery,
    adapter: Ecto.Adapters.Postgres

  use Scrivener,
    page_size: Application.get_env(:ex_brewery, :page_size, 10)
end
