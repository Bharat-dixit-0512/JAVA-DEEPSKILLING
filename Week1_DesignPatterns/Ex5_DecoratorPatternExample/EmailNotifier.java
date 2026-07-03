package Week1_DesignPatterns.Ex5_DecoratorPatternExample;

public class EmailNotifier implements Notifier {
    @Override
    public void send(String message) {
        System.out.println("Sending Email notification: " + message);
    }
}
