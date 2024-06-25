defmodule DeGymApp.ExerciseContextTest do
  use DeGymApp.DataCase

  alias DeGymApp.ExerciseContext

  describe "exercises" do
    alias DeGymApp.ExerciseContext.Exercise

    import DeGymApp.ExerciseContextFixtures

    @invalid_attrs %{description: nil, name: nil, reps: nil, sets: nil}

    test "list_exercises/0 returns all exercises" do
      exercise = exercise_fixture()
      assert ExerciseContext.list_exercises() == [exercise]
    end

    test "get_exercise!/1 returns the exercise with given id" do
      exercise = exercise_fixture()
      assert ExerciseContext.get_exercise!(exercise.id) == exercise
    end

    test "create_exercise/1 with valid data creates a exercise" do
      valid_attrs = %{description: "some description", name: "some name", reps: 42, sets: 42}

      assert {:ok, %Exercise{} = exercise} = ExerciseContext.create_exercise(valid_attrs)
      assert exercise.description == "some description"
      assert exercise.name == "some name"
      assert exercise.reps == 42
      assert exercise.sets == 42
    end

    test "create_exercise/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ExerciseContext.create_exercise(@invalid_attrs)
    end

    test "update_exercise/2 with valid data updates the exercise" do
      exercise = exercise_fixture()
      update_attrs = %{description: "some updated description", name: "some updated name", reps: 43, sets: 43}

      assert {:ok, %Exercise{} = exercise} = ExerciseContext.update_exercise(exercise, update_attrs)
      assert exercise.description == "some updated description"
      assert exercise.name == "some updated name"
      assert exercise.reps == 43
      assert exercise.sets == 43
    end

    test "update_exercise/2 with invalid data returns error changeset" do
      exercise = exercise_fixture()
      assert {:error, %Ecto.Changeset{}} = ExerciseContext.update_exercise(exercise, @invalid_attrs)
      assert exercise == ExerciseContext.get_exercise!(exercise.id)
    end

    test "delete_exercise/1 deletes the exercise" do
      exercise = exercise_fixture()
      assert {:ok, %Exercise{}} = ExerciseContext.delete_exercise(exercise)
      assert_raise Ecto.NoResultsError, fn -> ExerciseContext.get_exercise!(exercise.id) end
    end

    test "change_exercise/1 returns a exercise changeset" do
      exercise = exercise_fixture()
      assert %Ecto.Changeset{} = ExerciseContext.change_exercise(exercise)
    end
  end
end
