defmodule DeGymApp.TrainingContext do
  @moduledoc """
  The TrainingContext context.
  """

  import Ecto.Query, warn: false
  alias DeGymApp.ExerciseContext
  alias DeGymApp.ExerciseContext.Exercise
  alias DeGymApp.Repo
  import Ecto.Changeset

  alias DeGymApp.TrainingContext.Trainingplan

  @doc """
  Returns the list of trainingplans.

  ## Examples

      iex> list_trainingplans()
      [%Trainingplan{}, ...]

  """
  def list_trainingplans do
    Repo.all(Trainingplan)
  end

  @doc """
  Gets a single trainingplan.

  Raises `Ecto.NoResultsError` if the Trainingplan does not exist.

  ## Examples

      iex> get_trainingplan!(123)
      %Trainingplan{}

      iex> get_trainingplan!(456)
      ** (Ecto.NoResultsError)

  """
  def get_trainingplan!(id), do: Repo.get!(Trainingplan, id)



  def test(id) do
    %Trainingplan{}
      |> Repo.get!(Trainingplan, id)
      |> Repo.preload(:exercises)
  end

  @doc """
  Creates a trainingplan.

  ## Examples

      iex> create_trainingplan(%{field: value})
      {:ok, %Trainingplan{}}

      iex> create_trainingplan(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_trainingplan(attrs \\ %{}) do
    trainingplan = %Trainingplan{}
    |> Trainingplan.changeset(attrs)
    |> Repo.insert()

    Phoenix.PubSub.broadcast(DeGymApp.PubSub, "trainingplan", %{message: ""})
    trainingplan
  end

  @doc """
  Updates a trainingplan.

  ## Examples

      iex> update_trainingplan(trainingplan, %{field: new_value})
      {:ok, %Trainingplan{}}

      iex> update_trainingplan(trainingplan, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_trainingplan(%Trainingplan{} = trainingplan, attrs) do
    trainingplan
    |> Trainingplan.changeset(attrs)
    |> Repo.update()

    Phoenix.PubSub.broadcast(DeGymApp.PubSub, "trainingplan", %{message: ""})
    {:ok, trainingplan}
  end

  @doc """
  Deletes a trainingplan.

  ## Examples

      iex> delete_trainingplan(trainingplan)
      {:ok, %Trainingplan{}}

      iex> delete_trainingplan(trainingplan)
      {:error, %Ecto.Changeset{}}

  """
  def delete_trainingplan(%Trainingplan{} = trainingplan) do
    trainingplan
    |> Repo.preload(:clients)
    |> change()
    |> put_assoc(:clients, [])
    |> Repo.update()

    trainingplan
    |> Repo.preload(:exercises)
    |> change()
    |> put_assoc(:exercises, [])
    |> Repo.update()

    Repo.delete(trainingplan)
    Phoenix.PubSub.broadcast(DeGymApp.PubSub, "trainingplan", %{message: ""})
    {:ok, trainingplan}
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking trainingplan changes.

  ## Examples

      iex> change_trainingplan(trainingplan)
      %Ecto.Changeset{data: %Trainingplan{}}

  """
  def change_trainingplan(%Trainingplan{} = trainingplan, attrs \\ %{}) do
    Trainingplan.changeset(trainingplan, attrs)
  end

  def preload_exercises(%Trainingplan{} = trainingplan) do
    trainingplan
      |> Repo.preload(:exercises)
  end

  def filter_out_trainings_from_all(exclude) do
    list_trainingplans() |> Enum.reject(fn training -> training in exclude end)
  end

end
