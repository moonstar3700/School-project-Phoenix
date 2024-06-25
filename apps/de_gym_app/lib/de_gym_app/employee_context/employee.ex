defmodule DeGymApp.EmployeeContext.Employee do
  use Ecto.Schema
  import Ecto.Changeset
  alias DeGymApp.ClientContext.Client
  alias DeGymApp.EmployeeContext.Employee
  alias DeGymApp.Repo

  schema "employees" do
    field :email, :string
    field :firstname, :string
    field :lastname, :string
    has_many :clients, Client, on_replace: :nilify
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:firstname, :lastname, :email])
    |> validate_required([:firstname, :lastname, :email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> unsafe_validate_unique(:email, DeGymApp.Repo)
    |> unique_constraint(:email)
  end

  def assign_client(%Client{} = client, %Employee{} = employee) do
    employee
      |> Repo.preload(:clients)
      |> change()
      |> put_assoc(:clients, [client])

  end
end
