defmodule DeGymApp.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add :firstname, :string, null: false
      add :lastname, :string, null: false
      add :email, :string, null: false
      add :phone_nr, :string, null: false
      add :municipal, :string, null: false
      add :adress, :string, null: false
      add :employee_id, references(:employees)
    end
  end
end
