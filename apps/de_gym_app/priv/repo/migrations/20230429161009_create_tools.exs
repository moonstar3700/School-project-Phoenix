defmodule DeGymApp.Repo.Migrations.CreateTools do
  use Ecto.Migration

  def change do
    create table(:tools) do
      add :name, :string, null: false
      add :brand, :string, null: false
      add :amount, :integer, null: false
    end
  end
end
