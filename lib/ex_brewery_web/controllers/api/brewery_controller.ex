defmodule ExBreweryWeb.Api.BreweryController do
  use ExBreweryWeb, :controller

  alias ExBrewery.Barrel
  alias ExBrewery.Barrel.Brewery

  action_fallback ExBreweryWeb.FallbackController

  # http://localhost:4000/api/breweries?page=2
  # http://localhost:4000/api/breweries?page=2&page_size=5
  def index(conn, params) do
    breweries = Barrel.list_breweries_page(params)
    render(conn, "index_paged.json", breweries: breweries)
  end

  def create(conn, %{"brewery" => brewery_params}) do
    with {:ok, %Brewery{} = brewery} <- Barrel.create_brewery(brewery_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_brewery_path(conn, :show, brewery))
      |> render("show.json", brewery: brewery)
    end
  end

  def show(conn, %{"id" => id}) do
    brewery = Barrel.get_brewery!(id)
    render(conn, "show.json", brewery: brewery)
  end

  def update(conn, %{"id" => id, "brewery" => brewery_params}) do
    brewery = Barrel.get_brewery!(id)

    with {:ok, %Brewery{} = brewery} <- Barrel.update_brewery(brewery, brewery_params) do
      render(conn, "show.json", brewery: brewery)
    end
  end

  def delete(conn, %{"id" => id}) do
    brewery = Barrel.get_brewery!(id)

    with {:ok, %Brewery{}} <- Barrel.delete_brewery(brewery) do
      send_resp(conn, :no_content, "")
    end
  end
end
