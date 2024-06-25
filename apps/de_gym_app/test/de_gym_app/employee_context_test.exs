defmodule DeGymApp.EmployeeContextTest do
  use DeGymApp.DataCase

  alias DeGymApp.EmployeeContext

  describe "employees" do
    alias DeGymApp.EmployeeContext.Employee

    import DeGymApp.EmployeeContextFixtures

    @invalid_attrs %{email: nil, firstname: nil, function: nil, lastname: nil}

    test "list_employees/0 returns all employees" do
      employee = employee_fixture()
      assert EmployeeContext.list_employees() == [employee]
    end

    test "get_employee!/1 returns the employee with given id" do
      employee = employee_fixture()
      assert EmployeeContext.get_employee!(employee.id) == employee
    end

    test "create_employee/1 with valid data creates a employee" do
      valid_attrs = %{email: "some email", firstname: "some firstname", function: "some function", lastname: "some lastname"}

      assert {:ok, %Employee{} = employee} = EmployeeContext.create_employee(valid_attrs)
      assert employee.email == "some email"
      assert employee.firstname == "some firstname"
      assert employee.function == "some function"
      assert employee.lastname == "some lastname"
    end

    test "create_employee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = EmployeeContext.create_employee(@invalid_attrs)
    end

    test "update_employee/2 with valid data updates the employee" do
      employee = employee_fixture()
      update_attrs = %{email: "some updated email", firstname: "some updated firstname", function: "some updated function", lastname: "some updated lastname"}

      assert {:ok, %Employee{} = employee} = EmployeeContext.update_employee(employee, update_attrs)
      assert employee.email == "some updated email"
      assert employee.firstname == "some updated firstname"
      assert employee.function == "some updated function"
      assert employee.lastname == "some updated lastname"
    end

    test "update_employee/2 with invalid data returns error changeset" do
      employee = employee_fixture()
      assert {:error, %Ecto.Changeset{}} = EmployeeContext.update_employee(employee, @invalid_attrs)
      assert employee == EmployeeContext.get_employee!(employee.id)
    end

    test "delete_employee/1 deletes the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{}} = EmployeeContext.delete_employee(employee)
      assert_raise Ecto.NoResultsError, fn -> EmployeeContext.get_employee!(employee.id) end
    end

    test "change_employee/1 returns a employee changeset" do
      employee = employee_fixture()
      assert %Ecto.Changeset{} = EmployeeContext.change_employee(employee)
    end
  end
end
