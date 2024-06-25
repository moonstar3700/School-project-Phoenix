defmodule DeGymApp.ExerciseContext.Exercise do
  use Ecto.Schema
  import Ecto.Changeset
  alias DeGymApp.ToolContext.Tool
  alias DeGymApp.TrainingContext.Trainingplan
  alias DeGymApp.ExerciseContext.Exercise

  schema "exercises" do
    field :description, :string
    field :name, :string
    field :reps, :integer
    field :sets, :integer
    belongs_to :tool, Tool
    many_to_many :trainingplans, Trainingplan, join_through: "exercises_trainingplans", on_replace: :delete
  end

  @doc false
  def changeset(exercise, attrs) do
    exercise
    |> cast(attrs, [:name, :sets, :reps, :description])
    |> validate_required([:name, :sets, :reps, :description])
    |> cast_assoc(:trainingplans)
  end

  def assign_exercise_to_training_changeset(%Trainingplan{} = trainingplan, %Exercise{} = exercise) do
    #put the exercise in the trainingsplan value called exercises
    new_training = [trainingplan | exercise.trainingplans]

    exercise
    |> change()
    |> put_assoc(:trainingplans, new_training)
  end
end
