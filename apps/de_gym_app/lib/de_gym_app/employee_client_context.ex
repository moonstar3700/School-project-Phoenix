defmodule DeGymApp.EmployeeClientContext do
  alias DeGymApp.ClientContext.Client
  alias DeGymApp.Repo
  alias DeGymApp.EmployeeContext.Employee

  def add_employee(client_id, employee_id) do
    client = Repo.get!(Client, client_id)
    employee = Repo.get!(Employee, employee_id)

    Employee.assign_client(client, employee)
    |> Repo.update()
    {:ok, "Trainer added to client."}
  end
end
