defmodule DeGymApp.ExerciseContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DeGymApp.ExerciseContext` context.
  """

  @doc """
  Generate a exercise.
  """
  def exercise_fixture(attrs \\ %{}) do
    {:ok, exercise} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        reps: 42,
        sets: 42
      })
      |> DeGymApp.ExerciseContext.create_exercise()

    exercise
  end
end
