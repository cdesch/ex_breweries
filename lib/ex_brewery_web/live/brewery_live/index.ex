defmodule ExBreweryWeb.BreweryLive.Index do
  @moduledoc """
  Brewery LiveView Index
  """
  use ExBreweryWeb, :live_view

  alias ExBrewery.Barrel
  alias ExBrewery.Barrel.Brewery

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :breweries, list_breweries())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Brewery")
    |> assign(:brewery, Barrel.get_brewery!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Brewery")
    |> assign(:brewery, %Brewery{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Breweries")
    |> assign(:brewery, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    brewery = Barrel.get_brewery!(id)
    {:ok, _} = Barrel.delete_brewery(brewery)

    {:noreply, assign(socket, :breweries, list_breweries())}
  end

  defp list_breweries do
    Barrel.list_breweries()
  end
end
