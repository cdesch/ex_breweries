defmodule ExBrewery.Barrel.Brewery do
  use Ecto.Schema
  import Ecto.Changeset

  schema "breweries" do
    field :address_2, :string
    field :address_3, :string
    field :brewery_type, :string
    field :city, :string
    field :country, :string
    field :county_province, :string
    field :latitude, :float
    field :longitude, :float
    field :name, :string
    field :obdb_id, :string
    field :phone, :string
    field :postal_code, :string
    field :state, :string
    field :street, :string
    field :tags, :string
    field :website_url, :string

    timestamps()
  end

  @doc false
  def changeset(brewery, attrs) do
    brewery
    |> cast(attrs, [:obdb_id, :name, :brewery_type, :street, :address_2, :address_3, :city, :state, :county_province, :postal_code, :website_url, :phone, :country, :longitude, :latitude, :tags])
    |> validate_required([:obdb_id, :name, :brewery_type, :city, :postal_code, :country])
    |> validate_required_inclusion([:state, :county_province])
    |> unique_constraint(:obdb_id)
  end


  def validate_required_inclusion(changeset, fields,  options \\ []) do
    if Enum.any?(fields, fn(field) -> get_field(changeset, field) end),
      do: changeset,
      else: add_error(changeset, hd(fields), "One of these fields must be present: #{inspect fields}")
  end
end
