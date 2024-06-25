defmodule DeGymAppWeb.ClientController do
  use DeGymAppWeb, :controller

  alias DeGymApp.ClientContext
  alias DeGymApp.ClientContext.Client
  alias DeGymApp.TrainingplanClient
  alias DeGymApp.TrainingContext
  alias DeGymApp.TrainingContext.Trainingplan
  alias DeGymApp.EmployeeContext.Employee
  alias DeGymApp.EmployeeContext
  alias DeGymApp.EmployeeClientContext

  def index(conn, _params) do
    clients = ClientContext.list_clients()
    render(conn, "index.html", clients: clients)
  end

  def new(conn, _params) do
    changeset = ClientContext.change_client(%Client{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"client" => client_params}) do
    case ClientContext.create_client(client_params) do
      {:ok, client} ->
        conn
        |> put_flash(:info, "Client created successfully.")
        |> redirect(to: Routes.client_path(conn, :show, client))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    client = ClientContext.get_client!(id)
    client = ClientContext.preload_trainingplans(client)
    client = ClientContext.preload_employee(client)
    render(conn, "show.html", client: client)
  end

  def edit(conn, %{"id" => id}) do
    client = ClientContext.get_client!(id)
    client = ClientContext.preload_trainingplans(client)
    client = ClientContext.preload_employee(client)
    added_employee = client.employee
    employees = EmployeeContext.list_employees()
    changeset = ClientContext.change_client(client)

    # added trainer
    # filtered list

    added_trainingplans = client.trainingplans
    trainingplans_not_in_client = TrainingContext.filter_out_trainings_from_all(added_trainingplans)

    render(conn, "edit.html", client: client, changeset: changeset, added_trainingplans: added_trainingplans, trainingplans_not_in_client: trainingplans_not_in_client, employees: employees, added_employee: added_employee)
  end

  def update(conn, %{"id" => id, "client" => client_params}) do
    client = ClientContext.get_client!(id)

    case ClientContext.update_client(client, client_params) do
      {:ok, client} ->
        conn
        |> put_flash(:info, "Client updated successfully.")
        |> redirect(to: Routes.client_path(conn, :show, client))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", client: client, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    client = ClientContext.get_client!(id)
    {:ok, _client} = ClientContext.delete_client(client)

    conn
    |> put_flash(:info, "Client deleted successfully.")
    |> redirect(to: Routes.client_path(conn, :index))
  end

  ###################################

  def add_trainingplan(conn, %{ "client_id" => client_id, "trainingplan_id" => training_id}) do
    client = ClientContext.get_client!(client_id)

    case TrainingplanClient.add_trainingplan(training_id, client_id) do
      {:ok, string} ->
        conn
        |> put_flash(:info, string)
        |> redirect(to: Routes.client_path(conn, :edit, client))
    end
  end

  def remove_trainingplan(conn, %{ "client_id" => client_id, "trainingplan_id" => training_id}) do
    client = ClientContext.get_client!(client_id)

    case TrainingplanClient.remove_trainingplan(training_id, client_id) do
      {:ok, string} ->
        conn
        |> put_flash(:info, string)
        |> redirect(to: Routes.client_path(conn, :edit, client))
    end
  end

  def add_employee(conn, %{"client_id" => client_id, "employee_id" => employee_id}) do
    client = ClientContext.get_client!(client_id)

    case EmployeeClientContext.add_employee(client_id, employee_id) do
      {:ok, string} ->
        conn
        |> put_flash(:info, string)
        |> redirect(to: Routes.client_path(conn, :edit, client))
    end

  end
end
