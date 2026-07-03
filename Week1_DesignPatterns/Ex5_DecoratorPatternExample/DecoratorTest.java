package Week1_DesignPatterns.Ex5_DecoratorPatternExample;

public class DecoratorTest {
    public static void main(String[] args) {
        Notifier emailNotifier = new EmailNotifier();

        Notifier emailAndSMSNotifier = new SMSNotifierDecorator(emailNotifier);

        Notifier allChannelsNotifier = new SlackNotifierDecorator(emailAndSMSNotifier);

        System.out.println("--- Sending notification via Email only ---");
        emailNotifier.send("Hello World!");

        System.out.println("\n--- Sending notification via Email and SMS ---");
        emailAndSMSNotifier.send("Hello World!");

        System.out.println("\n--- Sending notification via Email, SMS, and Slack ---");
        allChannelsNotifier.send("Hello World!");
    }
}
