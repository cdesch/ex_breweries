defmodule ExBreweryWeb.Api.BreweryView do
  use ExBreweryWeb, :view
  alias ExBreweryWeb.Api.BreweryView

  def render("index.json", %{breweries: breweries}) do
    %{data: render_many(breweries, BreweryView, "brewery.json")}
  end

  def render("show.json", %{brewery: brewery}) do
    %{data: render_one(brewery, BreweryView, "brewery.json")}
  end

  def render("brewery.json", %{brewery: brewery}) do
    %{
      id: brewery.id,
      obdb_id: brewery.obdb_id,
      name: brewery.name,
      brewery_type: brewery.brewery_type,
      street: brewery.street,
      address_2: brewery.address_2,
      address_3: brewery.address_3,
      city: brewery.city,
      state: brewery.state,
      county_province: brewery.county_province,
      postal_code: brewery.postal_code,
      website_url: brewery.website_url,
      phone: brewery.phone,
      country: brewery.country,
      longitude: brewery.longitude,
      latitude: brewery.latitude,
      tags: brewery.tags
    }
  end
end
