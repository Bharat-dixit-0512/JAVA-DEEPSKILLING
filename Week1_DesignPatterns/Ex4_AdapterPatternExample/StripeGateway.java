package Week1_DesignPatterns.Ex4_AdapterPatternExample;

public class StripeGateway {
    public void charge(double amount) {
        System.out.println("Charged $" + amount + " using Stripe.");
    }
}
