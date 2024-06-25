defmodule DeGymAppWeb.Live do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :counter, 0)}
  end

  def handle_event("inc", _, socket) do
    {:noreply, assign(socket, :counter, socket.assigns.counter + 1)}
  end

  def render(assigns) do
    ~L"""
    <div>
      <p>The gym app live</p>
      <h1>Counter: <%= @counter %></h1>
      <button phx-click="inc">Inc</button>
    </div>
    """
  end
end
