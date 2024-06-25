defmodule DeGymApp.Repo.Migrations.CreateTrainingPlansClients do
  use Ecto.Migration

  def change do
    create table(:trainingplans_clients) do
      add :trainingplan_id, references(:trainingplans)
      add :client_id, references(:clients)
    end
    create unique_index(:trainingplans_clients, [:trainingplan_id, :client_id])
  end
end
