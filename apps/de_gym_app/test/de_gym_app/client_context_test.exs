defmodule DeGymApp.ClientContextTest do
  use DeGymApp.DataCase

  alias DeGymApp.ClientContext

  describe "clients" do
    alias DeGymApp.ClientContext.Client

    import DeGymApp.ClientContextFixtures

    @invalid_attrs %{adress: nil, email: nil, firstname: nil, lastname: nil, municipal: nil, phone_nr: nil}

    test "list_clients/0 returns all clients" do
      client = client_fixture()
      assert ClientContext.list_clients() == [client]
    end

    test "get_client!/1 returns the client with given id" do
      client = client_fixture()
      assert ClientContext.get_client!(client.id) == client
    end

    test "create_client/1 with valid data creates a client" do
      valid_attrs = %{adress: "some adress", email: "some email", firstname: "some firstname", lastname: "some lastname", municipal: "some municipal", phone_nr: "some phone_nr"}

      assert {:ok, %Client{} = client} = ClientContext.create_client(valid_attrs)
      assert client.adress == "some adress"
      assert client.email == "some email"
      assert client.firstname == "some firstname"
      assert client.lastname == "some lastname"
      assert client.municipal == "some municipal"
      assert client.phone_nr == "some phone_nr"
    end

    test "create_client/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ClientContext.create_client(@invalid_attrs)
    end

    test "update_client/2 with valid data updates the client" do
      client = client_fixture()
      update_attrs = %{adress: "some updated adress", email: "some updated email", firstname: "some updated firstname", lastname: "some updated lastname", municipal: "some updated municipal", phone_nr: "some updated phone_nr"}

      assert {:ok, %Client{} = client} = ClientContext.update_client(client, update_attrs)
      assert client.adress == "some updated adress"
      assert client.email == "some updated email"
      assert client.firstname == "some updated firstname"
      assert client.lastname == "some updated lastname"
      assert client.municipal == "some updated municipal"
      assert client.phone_nr == "some updated phone_nr"
    end

    test "update_client/2 with invalid data returns error changeset" do
      client = client_fixture()
      assert {:error, %Ecto.Changeset{}} = ClientContext.update_client(client, @invalid_attrs)
      assert client == ClientContext.get_client!(client.id)
    end

    test "delete_client/1 deletes the client" do
      client = client_fixture()
      assert {:ok, %Client{}} = ClientContext.delete_client(client)
      assert_raise Ecto.NoResultsError, fn -> ClientContext.get_client!(client.id) end
    end

    test "change_client/1 returns a client changeset" do
      client = client_fixture()
      assert %Ecto.Changeset{} = ClientContext.change_client(client)
    end
  end
end
