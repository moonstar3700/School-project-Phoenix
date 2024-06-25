defmodule DeGymApp.Repo.Migrations.CreateExercisesTrainingPlans do
  use Ecto.Migration

  def change do
    create table(:exercises_trainingplans) do
      add :exercise_id, references(:exercises)
      add :trainingplan_id, references(:trainingplans)
    end
    create unique_index(:exercises_trainingplans, [:exercise_id, :trainingplan_id])
  end
end
