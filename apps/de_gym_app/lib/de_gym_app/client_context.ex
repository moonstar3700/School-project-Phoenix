defmodule DeGymApp.ClientContext do
  @moduledoc """
  The ClientContext context.
  """

  import Ecto.Query, warn: false
  alias DeGymApp.Repo
  import Ecto.Changeset
  alias DeGymApp.ClientContext.Client

  @doc """
  Returns the list of clients.

  ## Examples

      iex> list_clients()
      [%Client{}, ...]

  """
  def list_clients do
    Repo.all(Client)
  end

  @doc """
  Gets a single client.

  Raises `Ecto.NoResultsError` if the Client does not exist.

  ## Examples

      iex> get_client!(123)
      %Client{}

      iex> get_client!(456)
      ** (Ecto.NoResultsError)

  """
  def get_client!(id), do: Repo.get!(Client, id)

  @doc """
  Creates a client.

  ## Examples

      iex> create_client(%{field: value})
      {:ok, %Client{}}

      iex> create_client(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_client(attrs \\ %{}) do
    %Client{}
    |> Client.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a client.

  ## Examples

      iex> update_client(client, %{field: new_value})
      {:ok, %Client{}}

      iex> update_client(client, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_client(%Client{} = client, attrs) do
    client
    |> Client.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a client.

  ## Examples

      iex> delete_client(client)
      {:ok, %Client{}}

      iex> delete_client(client)
      {:error, %Ecto.Changeset{}}

  """
  def delete_client(%Client{} = client) do
    client
    |> Repo.preload(:trainingplans)
    |> change()
    |> put_assoc(:trainingplans, [])
    |> Repo.update()

    client
    |> Repo.preload(:employee)
    |> change()
    |> delete_change(:employee)
    |> Repo.update!

    Repo.delete(client)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking client changes.

  ## Examples

      iex> change_client(client)
      %Ecto.Changeset{data: %Client{}}

  """
  def change_client(%Client{} = client, attrs \\ %{}) do
    Client.changeset(client, attrs)
  end

  def preload_trainingplans(%Client{} = client) do
    client
    |> Repo.preload(:trainingplans)
  end

  def preload_employee(%Client{} = client) do
    client
    |> Repo.preload(:employee)
  end

end
