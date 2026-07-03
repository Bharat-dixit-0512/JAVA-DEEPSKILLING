package Week1_DesignPatterns.Ex10_MVCPatternExample;

public class MVCTest {
    public static void main(String[] args) {
        Student model = retrieveStudentFromDatabase();

        StudentView view = new StudentView();

        StudentController controller = new StudentController(model, view);

        System.out.println("--- Initial Student Details ---");
        controller.updateView();

        System.out.println("\n--- Updating Student Details ---");
        controller.setStudentGrade("A+");
        controller.setStudentName("John Doe Updated");
        controller.updateView();
    }

    private static Student retrieveStudentFromDatabase() {
        Student student = new Student();
        student.setName("John Doe");
        student.setId("S12345");
        student.setGrade("A");
        return student;
    }
}
