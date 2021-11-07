defmodule ExBreweryWeb.PageController do
  use ExBreweryWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
