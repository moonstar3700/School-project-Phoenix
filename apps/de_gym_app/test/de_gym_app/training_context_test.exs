defmodule DeGymApp.TrainingContextTest do
  use DeGymApp.DataCase

  alias DeGymApp.TrainingContext

  describe "trainingplans" do
    alias DeGymApp.TrainingContext.Trainingplan

    import DeGymApp.TrainingContextFixtures

    @invalid_attrs %{description: nil, level: nil, name: nil}

    test "list_trainingplans/0 returns all trainingplans" do
      trainingplan = trainingplan_fixture()
      assert TrainingContext.list_trainingplans() == [trainingplan]
    end

    test "get_trainingplan!/1 returns the trainingplan with given id" do
      trainingplan = trainingplan_fixture()
      assert TrainingContext.get_trainingplan!(trainingplan.id) == trainingplan
    end

    test "create_trainingplan/1 with valid data creates a trainingplan" do
      valid_attrs = %{description: "some description", level: "some level", name: "some name"}

      assert {:ok, %Trainingplan{} = trainingplan} = TrainingContext.create_trainingplan(valid_attrs)
      assert trainingplan.description == "some description"
      assert trainingplan.level == "some level"
      assert trainingplan.name == "some name"
    end

    test "create_trainingplan/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TrainingContext.create_trainingplan(@invalid_attrs)
    end

    test "update_trainingplan/2 with valid data updates the trainingplan" do
      trainingplan = trainingplan_fixture()
      update_attrs = %{description: "some updated description", level: "some updated level", name: "some updated name"}

      assert {:ok, %Trainingplan{} = trainingplan} = TrainingContext.update_trainingplan(trainingplan, update_attrs)
      assert trainingplan.description == "some updated description"
      assert trainingplan.level == "some updated level"
      assert trainingplan.name == "some updated name"
    end

    test "update_trainingplan/2 with invalid data returns error changeset" do
      trainingplan = trainingplan_fixture()
      assert {:error, %Ecto.Changeset{}} = TrainingContext.update_trainingplan(trainingplan, @invalid_attrs)
      assert trainingplan == TrainingContext.get_trainingplan!(trainingplan.id)
    end

    test "delete_trainingplan/1 deletes the trainingplan" do
      trainingplan = trainingplan_fixture()
      assert {:ok, %Trainingplan{}} = TrainingContext.delete_trainingplan(trainingplan)
      assert_raise Ecto.NoResultsError, fn -> TrainingContext.get_trainingplan!(trainingplan.id) end
    end

    test "change_trainingplan/1 returns a trainingplan changeset" do
      trainingplan = trainingplan_fixture()
      assert %Ecto.Changeset{} = TrainingContext.change_trainingplan(trainingplan)
    end
  end
end
