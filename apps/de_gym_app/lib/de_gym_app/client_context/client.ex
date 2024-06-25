defmodule DeGymApp.ClientContext.Client do
  use Ecto.Schema
  import Ecto.Changeset
  alias DeGymApp.EmployeeContext.Employee
  alias DeGymApp.TrainingContext.Trainingplan
  alias DeGymApp.Repo
  alias DeGymApp.ClientContext.Client

  schema "clients" do
    field :adress, :string
    field :email, :string
    field :firstname, :string
    field :lastname, :string
    field :municipal, :string
    field :phone_nr, :string
    belongs_to :employee, Employee, on_replace: :delete
    many_to_many :trainingplans, Trainingplan, join_through: "trainingplans_clients", on_replace: :delete
  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, [:firstname, :lastname, :email, :phone_nr, :municipal, :adress])
    |> validate_required([:firstname, :lastname, :email, :phone_nr, :municipal, :adress])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> unsafe_validate_unique(:email, DeGymApp.Repo)
    |> unique_constraint(:email)
    |> validate_format(:phone_nr, ~r/^\d{3}-\d{3}-\d{4}$/, message: "only the following format is valid XXX-XXX-XXXX")
  end

  def changeset_trainings(client, attrs) do
    client
    |> cast(attrs, [:firstname, :lastname, :email, :phone_nr, :municipal, :adress, :trainingplans])
    |> validate_required([:firstname, :lastname, :email, :phone_nr, :municipal, :adress, :trainingplans])
  end

  def add_training_to_client(%Trainingplan{} = trainingplan, %Client{} = client) do
    preload_client =
      client
      |> Repo.preload(:trainingplans)

    preloaded_trainings = Repo.preload(trainingplan, :clients)
    new_trainings = [trainingplan | preload_client.trainingplans]

    preload_client
    |> cast(%{}, [])
    |> put_assoc(:trainingplans, new_trainings)
  end

  def remove_training_from_client(%Trainingplan{} = trainingplan, %Client{} = client) do
    preload_client =
      client
      |> Repo.preload(:trainingplans)

    preloaded_trainings = Repo.preload(trainingplan, :clients)
    new_trainings = List.delete(preload_client.trainingplans, trainingplan)

    preload_client
    |> change()
    |> put_assoc(:trainingplans, new_trainings)
  end
end
