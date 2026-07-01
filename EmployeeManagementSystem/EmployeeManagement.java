package EmployeeManagementSystem;

public class EmployeeManagement {

    Employee[] employees = new Employee[10];
    int count = 0;

    // Add Employee
    public void addEmployee(Employee employee) {

        if (count < employees.length) {
            employees[count] = employee;
            count++;
            System.out.println("Employee Added Successfully.");
        } else {
            System.out.println("Employee Array is Full.");
        }
    }

    // Search Employee
    public void searchEmployee(int id) {

        for (int i = 0; i < count; i++) {

            if (employees[i].employeeId == id) {

                System.out.println("Employee Found:");
                System.out.println(employees[i]);
                return;
            }
        }

        System.out.println("Employee Not Found.");
    }

    // Traverse Employees
    public void traverseEmployees() {

        System.out.println("\nEmployee List:");

        for (int i = 0; i < count; i++) {
            System.out.println(employees[i]);
        }
    }

    // Delete Employee
    public void deleteEmployee(int id) {

        int index = -1;

        for (int i = 0; i < count; i++) {

            if (employees[i].employeeId == id) {
                index = i;
                break;
            }
        }

        if (index == -1) {
            System.out.println("Employee Not Found.");
            return;
        }

        for (int i = index; i < count - 1; i++) {
            employees[i] = employees[i + 1];
        }

        employees[count - 1] = null;
        count--;

        System.out.println("Employee Deleted Successfully.");
    }

    public static void main(String[] args) {

        EmployeeManagement management = new EmployeeManagement();

        management.addEmployee(new Employee(101, "Amit", "Manager", 60000));

        management.addEmployee(new Employee(102, "Rahul", "Developer", 50000));

        management.addEmployee(new Employee(103, "Neha", "Tester", 45000));

        management.traverseEmployees();

        management.searchEmployee(102);

        management.deleteEmployee(102);

        management.traverseEmployees();
    }
}