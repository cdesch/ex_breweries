defmodule ExBrewery.Repo.Migrations.CreateBreweries do
  use Ecto.Migration

  def change do
    create table(:breweries) do
      add :obdb_id, :string
      add :name, :string
      add :brewery_type, :string
      add :street, :string
      add :address_2, :string
      add :address_3, :string
      add :city, :string
      add :state, :string
      add :county_province, :string
      add :postal_code, :string
      add :website_url, :string
      add :phone, :string
      add :country, :string
      add :longitude, :float
      add :latitude, :float
      add :tags, :string

      timestamps()
    end

    create unique_index(:breweries, [:obdb_id])
  end
end
