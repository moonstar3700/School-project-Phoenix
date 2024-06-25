defmodule DeGymApp.ToolContext.Tool do
  use Ecto.Schema
  import Ecto.Changeset
  alias DeGymApp.ExerciseContext.Exercise

  schema "tools" do
    field :amount, :integer
    field :brand, :string
    field :name, :string
    has_many :exercises, Exercise
  end

  @doc false
  def changeset(tool, attrs) do
    tool
    |> cast(attrs, [:name, :brand, :amount])
    |> validate_required([:name, :brand, :amount])
  end
end
