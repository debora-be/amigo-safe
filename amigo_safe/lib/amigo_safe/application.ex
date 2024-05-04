defmodule AmigoSafe.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AmigoSafeWeb.Telemetry,
      AmigoSafe.Repo,
      {DNSCluster, query: Application.get_env(:amigo_safe, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AmigoSafe.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: AmigoSafe.Finch},
      # Start a worker by calling: AmigoSafe.Worker.start_link(arg)
      # {AmigoSafe.Worker, arg},
      # Start to serve requests, typically the last entry
      AmigoSafeWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AmigoSafe.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AmigoSafeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
