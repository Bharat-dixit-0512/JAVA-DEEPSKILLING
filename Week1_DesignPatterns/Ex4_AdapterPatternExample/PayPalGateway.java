package Week1_DesignPatterns.Ex4_AdapterPatternExample;

public class PayPalGateway {
    public void makePayment(double amount) {
        System.out.println("Payment of $" + amount + " processed through PayPal.");
    }
}
