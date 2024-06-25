defmodule DeGymAppWeb.TrainingplanControllerTest do
  use DeGymAppWeb.ConnCase

  import DeGymApp.TrainingContextFixtures

  @create_attrs %{description: "some description", level: "some level", name: "some name"}
  @update_attrs %{description: "some updated description", level: "some updated level", name: "some updated name"}
  @invalid_attrs %{description: nil, level: nil, name: nil}

  describe "index" do
    test "lists all trainingplans", %{conn: conn} do
      conn = get(conn, Routes.trainingplan_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Trainingplans"
    end
  end

  describe "new trainingplan" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.trainingplan_path(conn, :new))
      assert html_response(conn, 200) =~ "New Trainingplan"
    end
  end

  describe "create trainingplan" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.trainingplan_path(conn, :create), trainingplan: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.trainingplan_path(conn, :show, id)

      conn = get(conn, Routes.trainingplan_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Trainingplan"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.trainingplan_path(conn, :create), trainingplan: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Trainingplan"
    end
  end

  describe "edit trainingplan" do
    setup [:create_trainingplan]

    test "renders form for editing chosen trainingplan", %{conn: conn, trainingplan: trainingplan} do
      conn = get(conn, Routes.trainingplan_path(conn, :edit, trainingplan))
      assert html_response(conn, 200) =~ "Edit Trainingplan"
    end
  end

  describe "update trainingplan" do
    setup [:create_trainingplan]

    test "redirects when data is valid", %{conn: conn, trainingplan: trainingplan} do
      conn = put(conn, Routes.trainingplan_path(conn, :update, trainingplan), trainingplan: @update_attrs)
      assert redirected_to(conn) == Routes.trainingplan_path(conn, :show, trainingplan)

      conn = get(conn, Routes.trainingplan_path(conn, :show, trainingplan))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, trainingplan: trainingplan} do
      conn = put(conn, Routes.trainingplan_path(conn, :update, trainingplan), trainingplan: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Trainingplan"
    end
  end

  describe "delete trainingplan" do
    setup [:create_trainingplan]

    test "deletes chosen trainingplan", %{conn: conn, trainingplan: trainingplan} do
      conn = delete(conn, Routes.trainingplan_path(conn, :delete, trainingplan))
      assert redirected_to(conn) == Routes.trainingplan_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.trainingplan_path(conn, :show, trainingplan))
      end
    end
  end

  defp create_trainingplan(_) do
    trainingplan = trainingplan_fixture()
    %{trainingplan: trainingplan}
  end
end
