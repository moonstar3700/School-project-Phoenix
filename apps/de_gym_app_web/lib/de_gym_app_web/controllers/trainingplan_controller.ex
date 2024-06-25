defmodule DeGymAppWeb.TrainingplanController do
  use DeGymAppWeb, :controller

  alias DeGymApp.TrainingContext
  alias DeGymApp.TrainingContext.Trainingplan
  alias DeGymApp.ExerciseContext
  alias DeGymApp.ExerciseContext.Exercise
  alias DeGymApp.Repo
  alias DeGymApp.TrainingplanExerciseContext

  def index(conn, _params) do
    trainingplans = TrainingContext.list_trainingplans()
    render(conn, "index.html", trainingplans: trainingplans)
  end

  def new(conn, _params) do
    changeset = TrainingContext.change_trainingplan(%Trainingplan{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"trainingplan" => trainingplan_params}) do
    case TrainingContext.create_trainingplan(trainingplan_params) do
      {:ok, trainingplan} ->
        conn
        |> put_flash(:info, "Trainingplan created successfully.")
        |> redirect(to: Routes.trainingplan_path(conn, :show, trainingplan))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    trainingplan = TrainingContext.get_trainingplan!(id)
    trainingplan = TrainingContext.preload_exercises(trainingplan)
    render(conn, "show.html", trainingplan: trainingplan)
  end

  def edit(conn, %{"id" => id}) do
    trainingplan = TrainingContext.get_trainingplan!(id)
    trainingplan = TrainingContext.preload_exercises(trainingplan)
    changeset = TrainingContext.change_trainingplan(trainingplan)
    IO.puts("edit")

    added_exercises = trainingplan.exercises
    exercises_not_in_training = ExerciseContext.filter_out_exercises_from_all(added_exercises)

    render(conn, "edit.html", trainingplan: trainingplan, changeset: changeset, added_exercises: added_exercises, exercises_not_in_training: exercises_not_in_training)
  end

  def update(conn, %{"id" => id, "trainingplan" => trainingplan_params}) do
    trainingplan = TrainingContext.get_trainingplan!(id)
    changeset = TrainingContext.change_trainingplan(trainingplan)

    case TrainingContext.update_trainingplan(trainingplan, trainingplan_params) do
      {:ok, trainingplan} ->
        conn
        |> put_flash(:info, "Trainingplan updated successfully.")
        |> redirect(to: Routes.trainingplan_path(conn, :show, trainingplan))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", trainingplan: trainingplan, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    trainingplan = TrainingContext.get_trainingplan!(id)
    {:ok, _trainingplan} = TrainingContext.delete_trainingplan(trainingplan)

    conn
    |> put_flash(:info, "Trainingplan deleted successfully.")
    |> redirect(to: Routes.trainingplan_path(conn, :index))
  end

  #####################""

  def delete_exercise(conn, %{"trainingplan_id" => training_id, "exercise_id" => exercise_id}) do
    trainingplan = TrainingContext.get_trainingplan!(training_id)

    case TrainingplanExerciseContext.remove_exercise(training_id, exercise_id) do
    {:ok, string} ->
    conn
    |> put_flash(:info, string)
    |> redirect(to: Routes.trainingplan_path(conn, :edit, trainingplan))
    end
  end

  def add_exercise(conn, %{"trainingplan_id" => training_id, "exercise_id" => exercise_id}) do
    trainingplan = TrainingContext.get_trainingplan!(training_id)

    require IEx
    IEx.pry()

    case TrainingplanExerciseContext.add_exercise(training_id, exercise_id) do
      {:ok, string} ->
      conn
      |> put_flash(:info, string)
      |> redirect(to: Routes.trainingplan_path(conn, :edit, trainingplan))
    end
  end
end
