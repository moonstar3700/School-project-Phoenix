defmodule DeGymApp.TrainingContext.Trainingplan do
  use Ecto.Schema
  import Ecto.Changeset
  alias DeGymApp.ExerciseContext.Exercise
  alias DeGymApp.ClientContext.Client
  alias DeGymApp.TrainingContext.Trainingplan
  alias DeGymApp.ExerciseContext.Exercise
  alias DeGymApp.Repo

  schema "trainingplans" do
    field :description, :string
    field :level, :string
    field :name, :string
    many_to_many :exercises, Exercise, join_through: "exercises_trainingplans", on_replace: :delete
    many_to_many :clients, Client, join_through: "trainingplans_clients", on_replace: :delete
  end

  @doc false
  def changeset(trainingplan, attrs) do
    trainingplan
    |> cast(attrs, [:name, :level, :description])
    |> validate_required([:name, :level, :description])
  end

  @doc false
  def changeset_exercises(trainingplan, attrs) do
    trainingplan
    |> cast(attrs, [:name, :level, :description, :exercises])
    |> validate_required([:name, :level, :description, :exercises])
  end

  def assign_exercise_to_training(%Trainingplan{} = trainingplan, %Exercise{} = exercise) do
    preloaded_training =
      trainingplan
      |> Repo.preload(:exercises)

    preloaded_exercises = Repo.preload(exercise, :trainingplans)
    new_exercises = [exercise | preloaded_training.exercises]

    require IEx
    IEx.pry()

    preloaded_training
    |> cast(%{}, [])
    |> put_assoc(:exercises, new_exercises)
  end

  def remove_exercise_from_training_changeset(%Trainingplan{} = trainingplan, %Exercise{} = exercise) do
    preloaded_training =
      trainingplan
      |> Repo.preload(:exercises)

    preloaded_exercises = Repo.preload(exercise, :trainingplans)
    new_exercises = List.delete(preloaded_training.exercises, exercise)

    preloaded_training
      |> change()
      |> put_assoc(:exercises, new_exercises)
  end
end
