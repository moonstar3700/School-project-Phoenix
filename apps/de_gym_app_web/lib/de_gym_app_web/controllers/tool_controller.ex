defmodule DeGymAppWeb.ToolController do
  use DeGymAppWeb, :controller

  alias DeGymApp.ToolContext
  alias DeGymApp.ToolContext.Tool
  alias DeGymApp.ExerciseContext

  def index(conn, _params) do
    tools = ToolContext.list_tools()
    render(conn, "index.html", tools: tools)
  end

  def new(conn, _params) do
    changeset = ToolContext.change_tool(%Tool{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tool" => tool_params}) do
    case ToolContext.create_tool(tool_params) do
      {:ok, tool} ->
        conn
        |> put_flash(:info, "Tool created successfully.")
        |> redirect(to: Routes.tool_path(conn, :show, tool))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tool = ToolContext.get_tool!(id)
    render(conn, "show.html", tool: tool)
  end

  def edit(conn, %{"id" => id}) do
    tool = ToolContext.get_tool!(id)
    changeset = ToolContext.change_tool(tool)

    render(conn, "edit.html", tool: tool, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tool" => tool_params}) do
    tool = ToolContext.get_tool!(id)

    case ToolContext.update_tool(tool, tool_params) do
      {:ok, tool} ->
        conn
        |> put_flash(:info, "Tool updated successfully.")
        |> redirect(to: Routes.tool_path(conn, :show, tool))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tool: tool, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tool = ToolContext.get_tool!(id)
    {:ok, _tool} = ToolContext.delete_tool(tool)

    conn
    |> put_flash(:info, "Tool deleted successfully.")
    |> redirect(to: Routes.tool_path(conn, :index))
  end
end
