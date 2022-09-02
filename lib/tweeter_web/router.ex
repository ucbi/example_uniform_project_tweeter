defmodule TweeterWeb.Router do
  use TweeterWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TweeterWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TweeterWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/tweeter", TweeterWeb do
    pipe_through :browser

    live "/", TweetsLive, :tweets
  end
  


  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: TweeterWeb.Telemetry
    end
  end
end
