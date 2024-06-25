defmodule DeGymApp.ToolContextTest do
  use DeGymApp.DataCase

  alias DeGymApp.ToolContext

  describe "tools" do
    alias DeGymApp.ToolContext.Tool

    import DeGymApp.ToolContextFixtures

    @invalid_attrs %{amount: nil, brand: nil, name: nil}

    test "list_tools/0 returns all tools" do
      tool = tool_fixture()
      assert ToolContext.list_tools() == [tool]
    end

    test "get_tool!/1 returns the tool with given id" do
      tool = tool_fixture()
      assert ToolContext.get_tool!(tool.id) == tool
    end

    test "create_tool/1 with valid data creates a tool" do
      valid_attrs = %{amount: 42, brand: "some brand", name: "some name"}

      assert {:ok, %Tool{} = tool} = ToolContext.create_tool(valid_attrs)
      assert tool.amount == 42
      assert tool.brand == "some brand"
      assert tool.name == "some name"
    end

    test "create_tool/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ToolContext.create_tool(@invalid_attrs)
    end

    test "update_tool/2 with valid data updates the tool" do
      tool = tool_fixture()
      update_attrs = %{amount: 43, brand: "some updated brand", name: "some updated name"}

      assert {:ok, %Tool{} = tool} = ToolContext.update_tool(tool, update_attrs)
      assert tool.amount == 43
      assert tool.brand == "some updated brand"
      assert tool.name == "some updated name"
    end

    test "update_tool/2 with invalid data returns error changeset" do
      tool = tool_fixture()
      assert {:error, %Ecto.Changeset{}} = ToolContext.update_tool(tool, @invalid_attrs)
      assert tool == ToolContext.get_tool!(tool.id)
    end

    test "delete_tool/1 deletes the tool" do
      tool = tool_fixture()
      assert {:ok, %Tool{}} = ToolContext.delete_tool(tool)
      assert_raise Ecto.NoResultsError, fn -> ToolContext.get_tool!(tool.id) end
    end

    test "change_tool/1 returns a tool changeset" do
      tool = tool_fixture()
      assert %Ecto.Changeset{} = ToolContext.change_tool(tool)
    end
  end
end
