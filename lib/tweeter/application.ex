defmodule Tweeter.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the PubSub system
      {Phoenix.PubSub, name: Tweeter.PubSub},
      # Start the Endpoint (http/https)
      TweeterWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Tweeter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    TweeterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
