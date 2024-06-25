defmodule DeGymApp.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees) do
      add :firstname, :string, null: false
      add :lastname, :string, null: false
      add :email, :string, null: false
    end
  end
end
