defmodule ExBrewery.BarrelFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ExBrewery.Barrel` context.
  """

  @doc """
  Generate a unique brewery obdb_id.
  """
  def unique_brewery_obdb_id, do: "some obdb_id#{System.unique_integer([:positive])}"

  @doc """
  Generate a brewery.
  """
  def brewery_fixture(attrs \\ %{}) do
    {:ok, brewery} =
      attrs
      |> Enum.into(%{
        address_2: "some address_2",
        address_3: "some address_3",
        brewery_type: "some brewery_type",
        city: "some city",
        country: "some country",
        county_province: "some county_province",
        latitude: 120.5,
        longitude: 120.5,
        name: "some name",
        obdb_id: unique_brewery_obdb_id(),
        phone: "some phone",
        postal_code: "some postal_code",
        state: "some state",
        street: "some street",
        tags: "some tags",
        website_url: "some website_url"
      })
      |> ExBrewery.Barrel.create_brewery()

    brewery
  end
end
