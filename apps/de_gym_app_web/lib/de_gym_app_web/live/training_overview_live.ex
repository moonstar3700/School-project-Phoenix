defmodule DeGymAppWeb.TrainingOverviewLive do
  use Phoenix.LiveView
  alias DeGymApp.TrainingContext

  def mount(_params, _session, socket) do
    DeGymAppWeb.Endpoint.subscribe("trainingplan")
    {:ok, assign(socket, :trainingplans, TrainingContext.list_trainingplans())}
  end

  def handle_info({Phoenix.PubSub, "trainingplan", _}, socket) do
    {:noreply, assign(socket, :trainingplans, TrainingContext.list_trainingplans())}
  end

  def handle_event("inc", _, socket) do
    {:noreply, assign(socket, :counter, socket.assigns.counter + 1)}
  end

end
