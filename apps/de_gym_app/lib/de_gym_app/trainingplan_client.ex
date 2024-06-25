defmodule DeGymApp.TrainingplanClient do
  alias DeGymApp.Repo
  alias DeGymApp.TrainingContext
  alias DeGymApp.TrainingContext.Trainingplan
  alias DeGymApp.ClientContext
  alias DeGymApp.ClientContext.Client

  def add_trainingplan(trainingplan_id, client_id) do
    trainingplan = Repo.get!(Trainingplan, trainingplan_id)
    client = Repo.get!(Client, client_id)

    Client.add_training_to_client(trainingplan, client)
    |> Repo.update()
    {:ok, "Training added to client."}
  end

  def remove_trainingplan(trainingplan_id, client_id) do
    trainingplan = Repo.get!(Trainingplan, trainingplan_id)
    client = Repo.get!(Client, client_id)

    Client.remove_training_from_client(trainingplan, client)
    |> Repo.update()
    {:ok, "Training removed from client."}
  end
end
