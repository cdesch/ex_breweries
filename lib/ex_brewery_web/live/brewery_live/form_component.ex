defmodule ExBreweryWeb.BreweryLive.FormComponent do
  @moduledoc """
  Brewery LiveView Form
  """
  use ExBreweryWeb, :live_component

  alias ExBrewery.Barrel

  @impl true
  def update(%{brewery: brewery} = assigns, socket) do
    changeset = Barrel.change_brewery(brewery)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"brewery" => brewery_params}, socket) do
    changeset =
      socket.assigns.brewery
      |> Barrel.change_brewery(brewery_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"brewery" => brewery_params}, socket) do
    save_brewery(socket, socket.assigns.action, brewery_params)
  end

  defp save_brewery(socket, :edit, brewery_params) do
    case Barrel.update_brewery(socket.assigns.brewery, brewery_params) do
      {:ok, _brewery} ->
        {:noreply,
         socket
         |> put_flash(:info, "Brewery updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_brewery(socket, :new, brewery_params) do
    case Barrel.create_brewery(brewery_params) do
      {:ok, _brewery} ->
        {:noreply,
         socket
         |> put_flash(:info, "Brewery created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
