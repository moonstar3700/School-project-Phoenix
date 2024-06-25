defmodule DeGymApp.EmployeeContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DeGymApp.EmployeeContext` context.
  """

  @doc """
  Generate a employee.
  """
  def employee_fixture(attrs \\ %{}) do
    {:ok, employee} =
      attrs
      |> Enum.into(%{
        email: "some email",
        firstname: "some firstname",
        function: "some function",
        lastname: "some lastname"
      })
      |> DeGymApp.EmployeeContext.create_employee()

    employee
  end
end
