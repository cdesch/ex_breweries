defmodule ExBreweryWeb.Router do
  use ExBreweryWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ExBreweryWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]

  end

  scope "/", ExBreweryWeb do
    pipe_through :browser

    get "/", PageController, :index

    live "/breweries", BreweryLive.Index, :index
    live "/breweries/new", BreweryLive.Index, :new
    live "/breweries/:id/edit", BreweryLive.Index, :edit

    live "/breweries/:id", BreweryLive.Show, :show
    live "/breweries/:id/show/edit", BreweryLive.Show, :edit
  end

  scope "/api", ExBreweryWeb.Api, as: :api do
    pipe_through :api
    resources "/breweries", BreweryController
  end


  # Other scopes may use custom stacks.
  # scope "/api", ExBreweryWeb do
  #   pipe_through :api
  #   resources "/breweries", BreweryController
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ExBreweryWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
