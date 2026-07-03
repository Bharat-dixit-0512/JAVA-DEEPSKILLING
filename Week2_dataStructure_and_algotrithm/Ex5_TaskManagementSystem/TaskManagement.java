package Week2_dataStructure_and_algotrithm.Ex5_TaskManagementSystem;

public class TaskManagement {

    Task head = null;

    // Add Task
    public void addTask(int id, String name, String status) {

        Task newTask = new Task(id, name, status);

        if (head == null) {
            head = newTask;
        } else {

            Task temp = head;

            while (temp.next != null) {
                temp = temp.next;
            }

            temp.next = newTask;
        }

        System.out.println("Task Added Successfully.");
    }

    // Search Task
    public void searchTask(int id) {

        Task temp = head;

        while (temp != null) {

            if (temp.taskId == id) {

                System.out.println("Task Found:");
                System.out.println(temp.taskId + " | " +
                        temp.taskName + " | " +
                        temp.status);
                return;
            }

            temp = temp.next;
        }

        System.out.println("Task Not Found.");
    }

    // Traverse Tasks
    public void traverseTasks() {

        System.out.println("\nTask List:");

        Task temp = head;

        while (temp != null) {

            System.out.println(temp.taskId + " | " +
                    temp.taskName + " | " +
                    temp.status);

            temp = temp.next;
        }
    }

    // Delete Task
    public void deleteTask(int id) {

        if (head == null) {
            System.out.println("Task List is Empty.");
            return;
        }

        if (head.taskId == id) {
            head = head.next;
            System.out.println("Task Deleted Successfully.");
            return;
        }

        Task temp = head;

        while (temp.next != null && temp.next.taskId != id) {
            temp = temp.next;
        }

        if (temp.next == null) {
            System.out.println("Task Not Found.");
        } else {
            temp.next = temp.next.next;
            System.out.println("Task Deleted Successfully.");
        }
    }

    public static void main(String[] args) {

        TaskManagement tm = new TaskManagement();

        tm.addTask(101, "Design UI", "Pending");
        tm.addTask(102, "Write Code", "In Progress");
        tm.addTask(103, "Testing", "Pending");

        tm.traverseTasks();

        tm.searchTask(102);

        tm.deleteTask(102);

        tm.traverseTasks();
    }
}