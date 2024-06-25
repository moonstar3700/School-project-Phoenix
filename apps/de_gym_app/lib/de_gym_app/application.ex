defmodule DeGymApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      DeGymApp.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: DeGymApp.PubSub}
      # Start a worker by calling: DeGymApp.Worker.start_link(arg)
      # {DeGymApp.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: DeGymApp.Supervisor)
  end
end
