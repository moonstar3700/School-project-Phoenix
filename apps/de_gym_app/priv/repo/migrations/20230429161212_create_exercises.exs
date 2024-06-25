defmodule DeGymApp.Repo.Migrations.CreateExercises do
  use Ecto.Migration

  def change do
    create table(:exercises) do
      add :name, :string, null: false
      add :sets, :integer, null: false
      add :reps, :integer, null: false
      add :description, :text
      add :tool_id, references(:tools)
    end
  end
end
