defmodule DeGymApp.TrainingContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DeGymApp.TrainingContext` context.
  """

  @doc """
  Generate a trainingplan.
  """
  def trainingplan_fixture(attrs \\ %{}) do
    {:ok, trainingplan} =
      attrs
      |> Enum.into(%{
        description: "some description",
        level: "some level",
        name: "some name"
      })
      |> DeGymApp.TrainingContext.create_trainingplan()

    trainingplan
  end
end
