defmodule DeGymApp.ToolContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DeGymApp.ToolContext` context.
  """

  @doc """
  Generate a tool.
  """
  def tool_fixture(attrs \\ %{}) do
    {:ok, tool} =
      attrs
      |> Enum.into(%{
        amount: 42,
        brand: "some brand",
        name: "some name"
      })
      |> DeGymApp.ToolContext.create_tool()

    tool
  end
end
