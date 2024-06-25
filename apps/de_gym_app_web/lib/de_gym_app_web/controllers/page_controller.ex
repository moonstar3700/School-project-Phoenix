defmodule DeGymAppWeb.PageController do
  use DeGymAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
