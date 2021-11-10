defmodule ExBreweryWeb.BreweryLive.Show do
  use ExBreweryWeb, :live_view

  alias ExBrewery.Barrel

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:brewery, Barrel.get_brewery!(id))}
  end

  defp page_title(:show), do: "Show Brewery"
  defp page_title(:edit), do: "Edit Brewery"
end
