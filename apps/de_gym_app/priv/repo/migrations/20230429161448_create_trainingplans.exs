defmodule DeGymApp.Repo.Migrations.CreateTrainingplans do
  use Ecto.Migration

  def change do
    create table(:trainingplans) do
      add :name, :string, null: false
      add :level, :string, null: false
      add :description, :text
    end
  end
end
