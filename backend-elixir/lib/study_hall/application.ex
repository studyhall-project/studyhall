defmodule StudyHall.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      StudyHallWeb.Telemetry,
      # Start the Ecto repository
      StudyHall.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: StudyHall.PubSub},
      # Start Finch
      {Finch, name: StudyHall.Finch},
      # Start the Endpoint (http/https)
      StudyHallWeb.Endpoint
      # Start a worker by calling: StudyHall.Worker.start_link(arg)
      # {StudyHall.Worker, arg}
    ]

    # https://hexdocs.pm/corsica/Corsica.Telemetry.html#attach_default_handler/1
    Corsica.Telemetry.attach_default_handler(log_levels: [rejected: :warning])

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: StudyHall.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    StudyHallWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
