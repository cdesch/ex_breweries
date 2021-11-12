defmodule ExBreweryWeb.Api.BreweryController do
  use ExBreweryWeb, :controller

  alias ExBrewery.Barrel
  alias ExBrewery.Barrel.Brewery

  action_fallback ExBreweryWeb.FallbackController

  def index(conn, _params) do
    breweries = Barrel.list_breweries()
    render(conn, "index.json", breweries: breweries)
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
