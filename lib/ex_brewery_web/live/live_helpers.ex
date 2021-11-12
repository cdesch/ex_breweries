defmodule ExBreweryWeb.LiveHelpers do
  @moduledoc """
  Brewery LiveView Helpers
  """
  import Phoenix.LiveView.Helpers

  @doc """
  Renders a component inside the `ExBreweryWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal ExBreweryWeb.BreweryLive.FormComponent,
        id: @brewery.id || :new,
        action: @live_action,
        brewery: @brewery,
        return_to: Routes.brewery_index_path(@socket, :index) %>
  """
  def live_modal(component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(ExBreweryWeb.ModalComponent, modal_opts)
  end
end
