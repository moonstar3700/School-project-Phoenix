defmodule DeGymAppWeb.ToolControllerTest do
  use DeGymAppWeb.ConnCase

  import DeGymApp.ToolContextFixtures

  @create_attrs %{amount: 42, brand: "some brand", name: "some name"}
  @update_attrs %{amount: 43, brand: "some updated brand", name: "some updated name"}
  @invalid_attrs %{amount: nil, brand: nil, name: nil}

  describe "index" do
    test "lists all tools", %{conn: conn} do
      conn = get(conn, Routes.tool_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Tools"
    end
  end

  describe "new tool" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.tool_path(conn, :new))
      assert html_response(conn, 200) =~ "New Tool"
    end
  end

  describe "create tool" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.tool_path(conn, :create), tool: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.tool_path(conn, :show, id)

      conn = get(conn, Routes.tool_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Tool"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.tool_path(conn, :create), tool: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Tool"
    end
  end

  describe "edit tool" do
    setup [:create_tool]

    test "renders form for editing chosen tool", %{conn: conn, tool: tool} do
      conn = get(conn, Routes.tool_path(conn, :edit, tool))
      assert html_response(conn, 200) =~ "Edit Tool"
    end
  end

  describe "update tool" do
    setup [:create_tool]

    test "redirects when data is valid", %{conn: conn, tool: tool} do
      conn = put(conn, Routes.tool_path(conn, :update, tool), tool: @update_attrs)
      assert redirected_to(conn) == Routes.tool_path(conn, :show, tool)

      conn = get(conn, Routes.tool_path(conn, :show, tool))
      assert html_response(conn, 200) =~ "some updated brand"
    end

    test "renders errors when data is invalid", %{conn: conn, tool: tool} do
      conn = put(conn, Routes.tool_path(conn, :update, tool), tool: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Tool"
    end
  end

  describe "delete tool" do
    setup [:create_tool]

    test "deletes chosen tool", %{conn: conn, tool: tool} do
      conn = delete(conn, Routes.tool_path(conn, :delete, tool))
      assert redirected_to(conn) == Routes.tool_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.tool_path(conn, :show, tool))
      end
    end
  end

  defp create_tool(_) do
    tool = tool_fixture()
    %{tool: tool}
  end
end
