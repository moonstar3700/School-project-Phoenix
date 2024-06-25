defmodule DeGymApp.TrainingplanExerciseContext do
  alias DeGymApp.ExerciseContext
  alias DeGymApp.ExerciseContext.Exercise
  alias DeGymApp.Repo

  alias DeGymApp.TrainingContext.Trainingplan

  def add_exercise(trainingplan_id, exercise_id) do

    trainingplan = Repo.get!(Trainingplan, trainingplan_id)
    exercise = Repo.get!(Exercise, exercise_id)

    Trainingplan.assign_exercise_to_training(trainingplan, exercise)
     |> Repo.update()
    {:ok, "Exercise added to training."}
  end

  def remove_exercise(trainingplan_id, exercise_id) do

    trainingplan = Repo.get!(Trainingplan, trainingplan_id)
    exercise = Repo.get!(Exercise, exercise_id)

    Trainingplan.remove_exercise_from_training_changeset(trainingplan, exercise)
     |> Repo.update()
    {:ok, "Exercise removed from training."}
  end

end
