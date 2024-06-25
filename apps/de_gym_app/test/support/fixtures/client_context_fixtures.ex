defmodule DeGymApp.ClientContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DeGymApp.ClientContext` context.
  """

  @doc """
  Generate a client.
  """
  def client_fixture(attrs \\ %{}) do
    {:ok, client} =
      attrs
      |> Enum.into(%{
        adress: "some adress",
        email: "some email",
        firstname: "some firstname",
        lastname: "some lastname",
        municipal: "some municipal",
        phone_nr: "some phone_nr"
      })
      |> DeGymApp.ClientContext.create_client()

    client
  end
end
