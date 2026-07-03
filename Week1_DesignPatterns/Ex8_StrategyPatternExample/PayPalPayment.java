package Week1_DesignPatterns.Ex8_StrategyPatternExample;

public class PayPalPayment implements PaymentStrategy {
    private String email;
    private String password;

    public PayPalPayment(String email, String password) {
        this.email = email;
        this.password = password;
    }

    @Override
    public void pay(double amount) {
        System.out.println("Paid $" + amount + " using PayPal (" + email + ").");
    }
}
